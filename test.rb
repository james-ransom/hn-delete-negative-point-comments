require 'minitest/autorun'
load 'watch.rb'

require 'minitest/autorun'

class Test < Minitest::Test
  def test_parse_for_deletable
    str="<br><br><>html>(FNLQNF)f>delete-confirm?id=18579492&amp;goto=threads%3Fid%3Dcatboy3920nfkasdfkldsajfkldsajfkldasjflksdafjklas><>delete-confirm?id=18579493&amp;gotfdskalf jkdlsafj kldas <br></html>testTEST delete-confirm?id=18579494&am"
    ids = parseForDeletable(str)
    assert ids.to_s == ["18579492", "18579493", "18579494"].to_s

    str="delete-confirm?id=1857949&amp;goto=threads%3Fid%3Dcatboy3920nfkasdfkldsajfkldsajfkldasjflksdafjklas><>delete-confirm?id=18579493&amp;gotfdskalf jkdlsafj kldas <br></html>testTEST delete-confirm?id=18579494&am delete-confirm?id "
    ids = parseForDeletable(str)
    assert ids.to_s == ["1857949", "18579493", "18579494"].to_s

    str="<br><br><>html>(FNLQNF)f>?id="
    ids = parseForDeletable(str)
    assert ids.to_s == [].to_s
  end

  def test_parse_for_bad_comments
     str='-- <span class="score" id="score_18572551">-17 points</span> by&amp;goto=threads%3Fid%3Dransom1538nfkasdfkldsajfkldsajfkldasjflksdafjklas><>delete-confirm?id=18579493&amp;gotfdskalf jkdlsafj kldas jfladsfsadkfkds afjkdsa jfkldsadelete-confirm?  <span class="score" id="score_18572552">-19 points</span> by id=18579494&am'
     deletable_ids = [18572551, 18572552]
     ids = parseForBadComments(deletable_ids, str, points_needed = 1)
     assert ids.to_s == [18572551, 18572552].to_s

     str='-- <span class="score" id="score_18572551">17 points</span> by&amp;goto=threads%3Fid%3Dransom1538nfkasdfkldsajfkldsajfkldasjflksdafjklas><>delete-confirm?id=18579493&amp;gotfdskalf jkdlsafj kldas jfladsfsadkfkds afjkdsa jfkldsadelete-confirm?  <span class="score" id="score_18572552">-19 points</span> by id=18579494&am'
     deletable_ids = [18572551, 18572552]
     ids = parseForBadComments(deletable_ids, str, points_needed = 1)
     assert ids.to_s == [18572552].to_s

     str='-- <span class="score" id="score_18572551">10 points</span> by&amp;goto=threads%3Fid%3Dransom1538nfkasdfkldsajfkldsajfkldasjflksdafjklas><>delete-confirm?id=18579493&amp;gotfdskalf jkdlsafj kldas jfladsfsadkfkds afjkdsa jfkldsadelete-confirm?  <span class="score" id="score_18572552">10 points</span> by id=18579494&am'
     deletable_ids = [18572551, 18572552]
     ids = parseForBadComments(deletable_ids, str, points_needed = 1)
     assert ids.to_s == [].to_s

      str='-- <span class="score" id="score_18572551">10 points</span> by&amp;goto=threads%3Fid%3Dransom1538nfkasdfkldsajfkldsajfkldasjflksdafjklas><>delete-confirm?id=18579493&amp;gotfdskalf jkdlsafj kldas jfladsfsadkfkds afjkdsa jfkldsadelete-confirm?  <span class="score" id="score_18572552">10 points</span> by id=18579494&am'
     deletable_ids = [18572551, 18572552]
     ids = parseForBadComments(deletable_ids, str, points_needed = 11)
     assert ids.to_s == [18572551, 18572552].to_s
  end

end
