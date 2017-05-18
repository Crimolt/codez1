module Jekyll
    module LastPost
        def lastPost(posts, category)
            for post in posts
                if post.categories.include?(category)
                    lastPost = post
                    break
                end
            end
            return lastPost
        end

        def lastPosts(posts, category, maxLength)
            res = []
            for post in posts
                if (category == '') 
                    res << post
                elsif post.categories.include?(category)
                    res << post
                end
                                  
                if (res.length >= maxLength)
                    break
                end
            end
            return res
        end
    end
end

Liquid::Template.register_filter(Jekyll::LastPost)