ActiveAdmin.register Map do
  index do
    column :id
    column 'Name', :sortable => :name do |map|
      link_to map.name, edit_admin_map_path(map)
    end
    column 'Image' do |map|
      image_tag map.image.url(:thumb)  unless map.image_file_name.blank?
    end
    column 'polygons' do |map|
      link_to 'edit polygons', edit_map_path(map)
    end
    default_actions
  end

  form :html => { :enctype => 'multipart/form-data' } do |f|
    f.inputs 'Details', :multipart => true do
      f.input :name
      f.input :description
      f.input :image
    end
    f.buttons
  end
  
end
