namespace :import do
  task :ndp => :environment do
    require 'pp'
    WORKING_DIR = File.dirname(__FILE__)
    raw_txt = IO.read(WORKING_DIR + '/ndp.txt')
    sections = raw_txt.split('–')
    sections.shift
    sections.each do |section|
      lines = section.split("\n")
      name = lines.shift.strip
      politician = Politician.find_by_name(name)
      if politician
        qa = ""
        lines.pop
        lines.each do |line|
          case line
          when /^\d\) (.+)/
            qa << "**#{$1}**" << "\n"
          else
            qa << line << "\n"
          end
        end
        politician.questionnaire = qa
        politician.save
      else
        puts "#{name} Not Found."
      end
    end
  end
end
