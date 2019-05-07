def get_hashtags(post)
  post.scan(/\B#(\w+)(?:\s|$)/).flatten.delete_if(&:empty?)
end

Test.assert_equals(get_hashtags("hello #world"), ["world"])
Test.assert_equals(get_hashtags("# # # #"), [])
