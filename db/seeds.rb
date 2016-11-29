# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
AdminUser.create!(nickname: 'ellen', email: 'ellen@lavadero.mx', password: 'password', password_confirmation: 'password')

User.create!(nickname: 'marco', name: 'marco', uid: 'marco@lavadero.mx', email: 'marco@lavadero.mx', password: 'password', password_confirmation: 'password')

q1 = Question.create!(text: "¿Cómo calificarías nuestro servicio?", question_type: "RATE", required: true, root: true)
q2 = Question.create!(text: "¿En qué podemos mejorar?", question_type: "SINGLE", required: true)
q3 = Question.create!(text: "¿Qué problema hubo con tu ropa?", question_type: "MULTIPLE", required: true)
q4 = Question.create!(text: "¿Cuál problema hubo con la puntualidad?", question_type: "MULTIPLE", required: true)
q5 = Question.create!(text: "Dinos si tuviste alguno de los siguientes problemas:", question_type: "MULTIPLE", required: true)

a1_1 = Answer.create!(text: "1", parent_question: q1, child_questions: [q2])
a1_2 = Answer.create!(text: "2", parent_question: q1, child_questions: [q2])
a1_3 = Answer.create!(text: "3", parent_question: q1, child_questions: [q2])
a1_4 = Answer.create!(text: "4", parent_question: q1)
a1_5 = Answer.create!(text: "5", parent_question: q1)

a2_1 = Answer.create!(text: "Calidad de la ropa", parent_question: q2, child_questions: [q3])
a2_2 = Answer.create!(text: "Puntualidad", parent_question: q2, child_questions: [q4])
a2_3 = Answer.create!(text: "Otro", parent_question: q2, child_questions: [q5])

a3_1 = Answer.create!(text: "Sucia", parent_question: q3)
a3_2 = Answer.create!(text: "Encogida", parent_question: q3)
a3_3 = Answer.create!(text: "Mal planchada", parent_question: q3)
a3_4 = Answer.create!(text: "Rota", parent_question: q3)
a3_5 = Answer.create!(text: "Faltó alguna prenda", parent_question: q3)

a4_1 = Answer.create!(text: "Recogieron fuera de horario", parent_question: q4)
a4_2 = Answer.create!(text: "Entregaron fuera de horario", parent_question: q4)
a4_3 = Answer.create!(text: "Entregaron en una fecha diferente a la de mi recibo", parent_question: q4)

a5_1 = Answer.create!(text: "Recibí ropa de alguien más", parent_question: q5)
a5_2 = Answer.create!(text: "No regresaron mi bolsa de lavado", parent_question: q5)
a5_3 = Answer.create!(text: "Problemas con el pago", parent_question: q5)
a5_4 = Answer.create!(text: "Mal servicio al cliente", parent_question: q5)
a5_5 = Answer.create!(text: "Mal servicio del bicimensajero", parent_question: q5)
a5_6 = Answer.create!(text: "Otro (especificar)", parent_question: q5)
