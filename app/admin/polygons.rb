ActiveAdmin.register Polygon do
  form do |f|
    f.inputs 'Parent Map' do
      f.input :map
    end
    f.inputs do
      f.input :link_type, :as => :radio, :collection => Polygon::POLYGON_TYPES
      f.input :constituency
      f.input :submap
      f.input :coordinates
    end
    f.buttons
  end

  index do
    column :id
    column :link_type
    column :map
    column :constituency
    column :submap
    default_actions
  end
  
end
