ActiveAdmin.register Page do
  index do
    column :id
    column :title do |page|
      link_to page.title, page.friendly_path
    end
    column :content do |page|
      truncate page.content
    end
    column :permalink
    default_actions
  end
  
end
