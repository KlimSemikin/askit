class UserBulkService < ApplicationService
  attr_reader :archive

  def initialize(archive_param)
    @archive = archive_param.tempfile
  end

  def call
    Zip::File.open(@archive) do |zip_file|
      zip_file.each do |entry|
        u = users_from(entry)
        User.import u, ignore: true
      end
    end
  end

  private

  def users_from(entry)
    sheet = RubyXL::Parser.parse_buffer(entry.get_input_stream.read)[0]
    sheet.map do |row|
      next if row.nil?

      cells = row.cells

      next if cells[0].nil?

      User.new(
        name: cells[0]&.value.to_s,
        email: cells[1]&.value.to_s,
        password: cells[2]&.value.to_s,
        password_confirmation: cells[2]&.value.to_s
      )
    end.compact
  end
end
