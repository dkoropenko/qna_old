class AttachmentsController < ApplicationController
	before_action :authenticate_user!

	before_action :find_attachment
	before_action :find_question
	before_action :find_answer

	def destroy
		@attachment.destroy	
	end

	private 

	def find_attachment
		@attachment = Attachment.find params[:id]
	end

	def find_question
		@question = Question.find(@attachment.attachable_id) if @attachment.attachable_type == 'Question'
	end

	def find_answer
		@answer = Answer.find(@attachment.attachable_id) if @attachment.attachable_type == 'Answer'
	end	
end