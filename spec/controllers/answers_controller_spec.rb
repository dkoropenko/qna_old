require 'rails_helper'

RSpec.describe AnswersController, type: :controller do
  let(:question) { create :question }
  let(:answer) { create :answer }

  describe 'GET #index' do
    let(:answers_list) { create_list(:answer, 2, question: question) }

    before do
      get :index, params: { question_id: question }
    end

    it 'find all answers for question' do
      expect(assigns :answers).to match_array(answers_list)
    end
    it 'render index view' do
      expect(response).to render_template :index
    end
  end

  describe 'GET #show' do
    before do
      get :show, params: { id: answer }
    end
    it 'find correct answer' do
      expect(assigns :answer).to eq answer
    end
    it 'render show view' do
      expect(response).to render_template :show
    end
  end

  describe 'GET #new' do
    before do
      get :new, params: { question_id: question }
    end

    it 'find correct answer' do
      expect(assigns :answer).to be_a_new Answer
    end

    it 'render new view' do
      expect(response).to render_template :new
    end
  end

  describe 'GET #edit' do
    before do
      get :edit, params: { id: answer }
    end
    it 'find correct answer' do
      expect(assigns :answer).to eq answer
    end
    it 'render show view' do
      expect(response).to render_template :edit
    end
  end

  describe 'POST #create' do
    context 'with valid attributes' do
      let(:post_answer) { post :create, params: { question_id: question, answer: attributes_for(:answer) } }

      it 'save new answer' do
        expect { post_answer }.to change(question.answers, :count).by(1)
      end
      it 'redirect to questions index view' do
        post_answer
        expect(response).to redirect_to questions_path
      end
    end

    context 'with invalid attributes' do
      let(:post_answer_invalid) { post :create, params: { question_id: question, answer: attributes_for(:invalid_answer) } }

      it 'does not save new answer' do
        expect { post_answer_invalid }.to_not change(question.answers, :count)
      end
      it 'render new view' do
        post_answer_invalid
        expect(response).to render_template :new
      end
    end
  end

  describe 'POST #update' do
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
    let(:delete_answer) { delete :destroy, params: { id: answer } }

    it 'deletes answer' do
      answer
      expect{delete_answer}.to change(Answer, :count).by(-1)
    end
    it 'redirect to questions index view' do
      delete_answer
      expect(response).to redirect_to questions_path
    end
  end
end
