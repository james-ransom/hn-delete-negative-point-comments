require 'rest-client'

# let's download the comments given cookies
def downloadComments(username, cookies)
  url = 'https://news.ycombinator.com/threads?id=' + username
  ret =  RestClient.get url, :user_agent => "Mozilla/5.0 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)", :cookies => cookies
  return ret
end

# let's find the HMAC token embedded into the confirmation delete form
def getHMACFromDeleteConfirmationPage(id, cookies)
  url = 'https://news.ycombinator.com/delete-confirm?id=' + id.to_s
  ret =  RestClient.get url, :user_agent => "Mozilla/5.0 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)", :cookies => cookies
  splits = ret.split('"hmac" value="')
  right_side = splits[1]
  hmac = right_side.split('"').first
  hmac
end

# let's find out what comments are deletable and return those comment ids
def parseForDeletable(str)
  splits = str.split("delete-confirm?id=")
  splits.shift #remove the first chunk of html not needed
  ids = []
  splits.each do |delete_token|
    id=delete_token.split("&").first
    ids << id
  end
  ids
end


# for all the deletable comments, let's see what their score is, if it isn't high enough, it's a bad comment
def parseForBadComments(deletable_ids, str, points_needed = 1)
  bad_comments = []
  deletable_ids.each do |delete_id|
    splits = str.split('id="score_'  + delete_id.to_s + '">' )
    points=splits[1].split(" ").first.to_i
    if points.to_i < points_needed.to_i
      bad_comments << delete_id
    end
  end
  bad_comments
end

# let's delete the comments given a list of comment ids we know are bad AND have the ability to be deleted
def deleteComments(delete_ids, cookies)
  delete_ids.each do |delete_id|
  hmac = getHMACFromDeleteConfirmationPage(delete_id, cookies)
  payloadString = "id=" + delete_id + "&hmac=" + hmac + "&d=Yes&goto="
  response = RestClient::Request.new({
    method: :post,
    url: 'https://news.ycombinator.com/xdelete',
    cookies: cookies,
    payload: payloadString,
  }).execute do |response, request, result|
    case response.code
      when 401..500
        raise "UNABLE TO DELETE COMMENTS"
      else
        puts "Deleting comment: "  + delete_id
      end
    end
  end
end

#Let's log in
def login(username, password)
  payloadString = "acct=" + username + "&pw=" + password
  response = RestClient::Request.new({
    method: :post,
    url: 'https://news.ycombinator.com/login',
    payload: payloadString,
     }).execute do |response, request, result|
    case response.code
    when 302
      { :success => response.cookies }
    else
      raise "UNABLE TO LOGIN"
    end
  end

end
