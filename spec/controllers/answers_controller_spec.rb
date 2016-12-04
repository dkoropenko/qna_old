require 'rails_helper'

RSpec.describe AnswersController, type: :controller do
  let(:answer) { create :answer }
  let(:question) { create :question }

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
                                       format: :js }

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
    describe 'Authenticated user' do
      before do
        @user = answer.user
        @request.env['devise.mapping'] = Devise.mappings[:user]
        sign_in @user
      end

      context 'with valid attributes' do
        before do
          patch :update, params: { id: answer, answer: { body: "NewLongAnswerBody", is_best: true }, format: :js }
        end

        it 'find correct answer' do
          expect(assigns :answer).to eq answer
        end

        it 'update answer' do
          answer.reload
          expect(answer.body).to eq "NewLongAnswerBody"
          expect(answer.is_best).to eq true
        end

        it 'response 200' do
          expect(response).to have_http_status :success
        end
      end

      context 'with invalid attributes' do
        before do
          patch :update, params: { id: answer, answer: { body: "", is_best: true }, format: :js }
        end
        it 'find correct answer' do
          expect(assigns :answer).to eq answer
        end
        it 'does not update answer' do
          expect(answer.body).to_not eq ""
          expect(answer.is_best).to eq false
        end
        it 'response 200' do
          expect(response).to have_http_status :success
        end
      end
    end

    context 'Non authenticated user' do

      context 'can not change answer' do
        before do
          patch :update, params: { id: answer, answer: { body: "NewLongAnswerBody", is_best: true }, format: :js }
        end

        it 'update answer' do
          answer.reload
          expect(answer.body).to_not eq "NewLongAnswerBody"
          expect(answer.is_best).to_not eq true
        end

        it 'response 401' do
          expect(response).to have_http_status 401
        end
      end

    end
  end

  describe 'PUT #choose best question' do
    describe 'Authenticated user' do
      before do
        @user = answer.question.user
        @request.env['devise.mapping'] = Devise.mappings[:user]
        sign_in @user
      end

      context 'With valid attributes' do
        before do
          patch :choose_best_answer, params: { id: answer.id, answer: { body: answer.body, is_best: true }, format: :js }
        end

        it 'choose best answer' do
          answer_body = answer.body
          answer.reload
          expect(answer.body).to eq answer_body
          expect(answer.is_best).to eq true
        end

        it "response 200" do
          expect(response).to have_http_status :success
        end
      end

      context 'With non valid attributes' do
        before do
          patch :choose_best_answer, params: { id: answer.id, answer: { body: 'ValidAnswerBody', is_best: nil }, format: :js }
        end

        it 'Can not choose best answer' do
          answer.reload
          expect(answer.body).to_not have_text "ValidAnswerBody"
          expect(answer.is_best).to eq false
        end

        it "response 200" do
          expect(response).to have_http_status :success
        end
      end
    end

    context 'Non Authenticated user' do
      before do
        patch :choose_best_answer, params: { id: answer.id, answer: { body: answer.body, is_best: true }, format: :js }
      end

      it 'Can not choose best answer' do
        answer_body = answer.body
        answer.reload
        expect(answer.body).to eq answer_body
        expect(answer.is_best).to eq false
      end

      it "response 401" do
        expect(response).to have_http_status 401
      end
    end

  end

  describe 'DELETE #destroy' do
    before { sign_in answer.user }

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
