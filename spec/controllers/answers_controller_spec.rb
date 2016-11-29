require 'rails_helper'

RSpec.describe AnswersController, type: :controller do
  let(:question) { create :question }
  let(:answer) { create :answer }

  describe 'POST #create' do
    sign_in_user

    context 'with valid attributes' do
      let(:post_answer) { post :create,
                               params: { question_id: question, answer: attributes_for(:answer) },
                               format: :js }

      it 'save new answer' do
        expect { post_answer }.to change(question.answers, :count).by(1)
      end
      it 'redirect to questions index view' do
        post_answer
        expect(response).to have_http_status :success
      end
    end

    context 'with invalid attributes' do
      let(:post_answer_invalid) { post :create,
                                       params: { question_id: question, answer: attributes_for(:invalid_answer) },
                                       format: :js}

      it 'does not save new answer' do
        expect { post_answer_invalid }.to_not change(question.answers, :count)
      end
      it 'render new view' do
        post_answer_invalid
        expect(response).to have_http_status :success
      end
    end
  end

  describe 'POST #update' do
    sign_in_user

    context 'with valid attributes' do
      before do
        patch :update, params: { id: answer, answer: { body: "NewLongAnswerBody", question_id: question.id } }
      end

      it 'find correct answer' do
        expect(assigns :answer).to eq answer
      end

      it 'update answer' do
        answer.reload
        expect(answer.body).to eq "NewLongAnswerBody"
        expect(answer.question_id).to eq question.id
      end
      it 'redirect to questions index view' do
        expect(response).to redirect_to questions_path
      end
    end

    context 'with invalid attributes' do
      before do
        patch :update, params: { id: answer, answer: { body: "", question_id: nil } }
      end
      it 'find correct answer' do
        expect(assigns :answer).to eq answer
      end
      it 'does not update answer' do
        expect(answer.body).to_not eq ""
        expect(answer.question_id).to_not eq nil
      end
      it 'render edit view' do
        expect(response).to render_template :edit
      end
    end
  end

  describe 'DELETE #destroy' do
    before { sign_in answer.user}

    let(:delete_answer) { delete :destroy, params: { id: answer } }

    it 'deletes answer' do
      answer
      expect { delete_answer }.to change(Answer, :count).by(-1)
    end
    it 'redirect to questions index view' do
      delete_answer
      expect(response).to redirect_to question_path answer.question
    end
  end
end
