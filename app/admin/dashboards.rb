ActiveAdmin::Dashboards.build do

  section "At a Glance", :priority => 1 do
    div do 
      render 'at_a_glance', { :politician_count => Politician.count, 
                              :constituency_count => Constituency.count }
    end
  end

  section "Recently Added Politicans", :priority => 2 do
    ul do
      Politician.limit(5).order("created_at DESC").each do |politician|
        li link_to(politician.name, admin_politician_path(politician))
      end
    end
  end

  section "Recently Updated Politicans", :priority => 2  do
    ul do
      Politician.limit(5).order("updated_at DESC").each do |politician|
        li link_to(politician.name, admin_politician_path(politician))
      end
    end
  end
 
  section "New Comments", :priority => 3 do
    ul do
      ActiveAdmin::Comment.limit(5).order("created_at DESC").each do |comment|
        li render('comment_snip', {:comment => comment})
      end
    end
  end

  section "Recently Added Constituencies", :priority => 3  do
    ul do
      Constituency.limit(5).order("created_at DESC").each do |politician|
        li link_to(politician.name, admin_politician_path(politician))
      end
    end
  end

  section "Recently Updated Constituencies", :priority => 3  do
    ul do
      Constituency.limit(5).order("updated_at DESC").each do |politician|
        li link_to(politician.name, admin_politician_path(politician))
      end
    end
  end

  section "Analytics", :priority => 4 do
    div do
      render 'analytics'
    end
  end


  # Define your dashboard sections here. Each block will be
  # rendered on the dashboard in the context of the view. So just
  # return the content which you would like to display.
  
  # == Simple Dashboard Section
  # Here is an example of a simple dashboard section
  #
  #   section "Recent Posts" do
  #     ul do
  #       Post.recent(5).collect do |post|
  #         li link_to(post.title, admin_post_path(post))
  #       end
  #     end
  #   end
  
  # == Render Partial Section
  # The block is rendererd within the context of the view, so you can
  # easily render a partial rather than build content in ruby.
  #
  #   section "Recent Posts" do
  #     render 'recent_posts' # => this will render /app/views/admin/dashboard/_recent_posts.html.erb
  #   end
  
  # == Section Ordering
  # The dashboard sections are ordered by a given priority from top left to
  # bottom right. The default priority is 10. By giving a section numerically lower
  # priority it will be sorted higher. For example:
  #
  #   section "Recent Posts", :priority => 10
  #   section "Recent User", :priority => 1
  #
  # Will render the "Recent Users" then the "Recent Posts" sections on the dashboard.

end
