class Attachment < ApplicationRecord
belongs_to :question

	mount_uploader :fule, FileUploader
end
