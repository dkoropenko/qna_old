require 'rails_helper'

RSpec.describe AttachmentsController, type: :controller do	
	describe '#REMOVE attachments' do
		describe 'Remove question attachment' do
			let(:question) { create :question }
			let!(:attachment) { create :attachment, attachable: question}
			let(:delete_attachment) { delete :destroy, params: { id: attachment }, format: :js }

			before { sign_in question.user }
		 	it 'Find current attachment' do
		 		delete_attachment
		 		expect(assigns :attachment).to eq attachment
		 	end

		 	it 'Remove current attachment' do		 		
		 		expect{ delete_attachment }.to change(Attachment, :count).by(-1)
		 	end
			it 'Response 200' do
				delete_attachment
				expect(response).to have_http_status :success
			end			 	
		end		

		describe 'Remove answer attachment' do
			let(:answer) { create :answer }
			let!(:attachment) { create :attachment, attachable: answer}
			let(:delete_attachment) { delete :destroy, params: { id: attachment }, format: :js }

			before { sign_in answer.user }
		 	it 'Find current attachment' do
		 		delete_attachment
		 		expect(assigns :attachment).to eq attachment
		 	end

		 	it 'Remove current attachment' do		 		
		 		expect{ delete_attachment }.to change(Attachment, :count).by(-1)
		 	end
			it 'Response 200' do
				delete_attachment
				expect(response).to have_http_status :success
			end			 	
		end		
	end
end
