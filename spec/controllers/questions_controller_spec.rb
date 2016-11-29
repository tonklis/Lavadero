feature 'QuestionsController' do
  
  let!(:question_01){create(:question, question_type: "RATE", root: true)}
  let!(:question_02){create(:question, question_type: "SINGLE")}
  let!(:question_03){create(:question, question_type: "MULTIPLE")}
  let!(:question_04){create(:question, question_type: "MULTIPLE")}

  let!(:answer_01){create(:answer, parent_question: question_01, child_questions: [question_02])}
  let!(:answer_02){create(:answer, parent_question: question_01)}
  let!(:answer_03){create(:answer, parent_question: question_02, child_questions: [question_03])}
  let!(:answer_04){create(:answer, parent_question: question_02, child_questions: [question_04])}
  let!(:answer_05){create(:answer, parent_question: question_03)}
  let!(:answer_06){create(:answer, parent_question: question_04)}

  context 'get question tree' do
      
    it 'should bring all the questions and nested answers' do

      visit tree_questions_path
      response = JSON.parse(page.body)

      questions = response["questions"][0]

      expect(questions["child_answers"][0]["child_questions"][0]["id"]).to eql question_02.id
      expect(questions["child_answers"][1]["id"]).to eql answer_02.id

      expect(questions["child_answers"][0]["child_questions"][0]["child_answers"][0]["id"]).to eql answer_03.id
      expect(questions["child_answers"][0]["child_questions"][0]["child_answers"][1]["id"]).to eql answer_04.id
      
      expect(questions["child_answers"][0]["child_questions"][0]["child_answers"][0]["child_questions"][0]["child_answers"][0]["id"]).to be answer_05.id
      expect(questions["child_answers"][0]["child_questions"][0]["child_answers"][0]["child_questions"][0]["child_answers"][0]["child_questions"]).to eql []
    end

  end

end
