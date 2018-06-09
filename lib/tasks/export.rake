namespace :export do
  require 'csv'
  require 'pp'

  def build_csv(array_of_hashes)
    CSV.generate do |csv|
      csv << array_of_hashes.first.keys
      array_of_hashes.each do |h|
        csv << h.values
      end
    end
  end

  task :constituencies => :environment do
  end

  task :parties => :environment do
    export_parties = Party.all.map do |party|
      {
        'name' => party.name,
        'slug' => party.slug,
        'description' => party.long_name,
        'colour' => party.hex_colour,
        'website' => party.website,
        'phone' => party.phone_number,
        'address' => party.address,
        'email' => party.email,
        'facebook' => party.facebook,
        'youtube' => party.youtube,
        'twitter' => party.twitter,
        'qanda_token' => '',
        'qanda_sent' => nil,
        'logo_base64' => nil,
        'logo_filename' => nil
      }
    end

    puts build_csv(export_parties)
  end
end
