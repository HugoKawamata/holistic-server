INSERT INTO set_lessons (id, title, image, unlocks_ids, course_id, skill_level, time_estimate)
VALUES ('GMR_NO', 'Possessions and Belonging', 'todo: add image link', 'GMR_JANAI', 'GRAMMAR_1', 'Beginner', 600);

INSERT INTO lectures (text, image, position, set_lesson_id, title)
VALUES (
  'Last time you learnt how to use past tense. This lesson you''ll learn how to say "''s" in Japanese.',
  'todo image',
  'PRETEST',
  'GMR_NO',
  'Apostrophe S'
),
(
  'In English, you can express ownership of something by using "''s". E.g. Alice''s cat; Tom''s hat.',
  'todo image',
  'PRETEST',
  'GMR_NO',
  'Apostrophe S'
),
(
  'Ownership can also change a word completely: E.g. Me → My; Him → His; Germany → German',
  'todo image',
  'PRETEST',
  'GMR_NO',
  'Special Cases'
),
(
  'In Japanese, it''s much easier! All you do is add the particle "の" (no) to the end of the word.',
  'todo image',
  'PRETEST',
  'GMR_NO',
  'Particle の'
),
(
  'For example, to say "my", you would say "{me}の".',
  'todo image',
  'PRETEST',
  'GMR_NO',
  'Particle の'
);

X: "You went to New Zealand? How was it?"
A: "It was beautiful!"

X: "What was that sound?"
A: "It was a bird"

A: "What was the yakitori like?"
X: "It was delicious!"

A: "How was the show?"
X: "It was fun!"

INSERT INTO words (japanese, hiragana, english, introduction, emoji, set_lesson_id)
VALUES ('下手', 'へた', 'Bad at, poor, unskilled', 'This means "bad at", as in "unskilled" at something, like drawing or singing.', '‍🤦', 'GMR_NO'),
       ('食べ物', 'たべもの', 'Food', 'This word means "food". The "Tabe" part literally means "eating", and the "mono" part means "thing".', '🍏', 'GMR_NO'),
       ('友達', 'ともだち', 'Friend', 'This means "friend".', '👥', 'GMR_NO');

insert into testables (
  set_lesson_id,
  person,
  location,
  context_jp,
  context_fg,
  context_en,
  possible_answers,
  question_text,
  question_text_fg,
  word_id,
  question_type,
  order_in_lesson,
  context_speaker,
  answer_type,
  question_prompt
)
values
(
  'GMR_NO',
  null,
  null,
  null,
  null,
  null,
  null,
  null,
  null,
  138,
  'J_WORD',
  1,
  null,
  'ROMAJI',
  null
),
(
  'GMR_NO',
  'YUJI_CHATTING',
  'HOSTEL_LOBBY',
  null,
  null,
  'Can you speak English?',
  'My English is bad/My English is poor/I''m bad at English/My English is pretty bad',
  '僕.の　英語.は　下手　です。',
  'ぼく.の　えいご.は　へた　です。',
  null,
  'J_SENTENCE',
  2,
  'You',
  'ENGLISH',
  'Translate Yuji''s reply'
),
(
  'GMR_NO',
  null,
  null,
  null,
  null,
  null,
  null,
  null,
  null,
  139,
  'J_WORD',
  3,
  null,
  'ROMAJI',
  null
),
(
  'GMR_NO',
  'HINAKO_CHATTING',
  'TOKYO_STREET',
  null,
  null,
  'What''s authentic Japanese food like?',
  'Japanese food is delicious',
  '日本.の　食べ物.は　うまい　です！',
  'にほん.の　たべもの.は　うまい　です！',
  null,
  'J_SENTENCE',
  4,
  'You',
  'ENGLISH',
  'Translate Hinako''s reply'
),
(
  'GMR_NO',
  null,
  null,
  null,
  null,
  null,
  null,
  null,
  null,
  140,
  'J_WORD',
  5,
  null,
  'ROMAJI',
  null
),
(
  'GMR_NO',
  'HINAKO_CHATTING',
  'RESTAURANT',
  null,
  null,
  'Wasn''t someone meeting us here?',
  'Yeah, my friend is a bit late/Yes, my friend is a bit late/Yeah, my friend is a little late/Yes, my friend is a little late',
  'はい、私の　友達は　ちょっと　遅い　です。',
  'にほん.の　たべもの.は　うまい　です！',
  null,
  'J_SENTENCE',
  6,
  'You',
  'ENGLISH',
  'Translate Hinako''s reply'
),
(
  'GMR_NO',
  'YUJI_CHATTING',
  'HOSTEL_LOBBY',
  '君.の　日本語.は？',
  'きみ.の　にほんご.は？',
  'How''s your Japanese?',
  '{me}.の　日本語.は　下手　です/{me_furi}.の　にほんご.は　へた　です/{me}.の　日本語.は　へた　です/{me}.の　にほんご.は　へた　です/{me}.の　にほんご.は　下手　です/{me_furi}.の　日本語.は　下手　です/{me_furi}.の　にほんご.は　下手　です/{me_furi}.の　日本語.は　へた　です',
  'My Japanese is bad',
  null,
  null,
  'E_SENTENCE',
  7,
  'Yuji',
  'JAPANESE',
  'Write your reply in Japanese'
),
(
  'GMR_NO',
  'HINAKO_EATING',
  'RESTAURANT',
  'どうして　そのよう.に　ラーメン.を　食べている.の？',
  'どうして　そのよう.に　ラーメン.を　食べている.の？',
  'Why is he eating his ramen like that?',
  '{me}.の　友達.は　変　です/{me_furi}.の　ともだち.は　へん　です/{me}.の　友達.は　へん　です/{me}.の　ともだち.は　変　です/{me}.の　ともだち.は　へん　です/{me_furi}.の　友達.は　変　です/{me_furi}.の　友達.は　へん　です/{me_furi}.の　ともだち.は　変　です',
  'My friend is weird...',
  null,
  null,
  'E_SENTENCE',
  8,
  'Hinako',
  'JAPANESE',
  'Write your reply in Japanese.'
),
(
  'GMR_NO',
  'HINAKO_CHATTING',
  'RESTAURANT',
  'どう　思う？私.は　正しい　です.か？',
  'どう　おもう？わたし.は　ただしい　です.か？',
  'What do you think? Was I right?',
  'はい、日本.の　食べ物.は　うまい　です/はい、にほん.の　たべもの.は　うまい　です/はい、にほん.の　食べ物.は　うまい　です/はい、日本.の　たべもの.は　うまい　です',
  'Yeah, Japanese food is delicious!',
  null,
  null,
  'E_SENTENCE',
  9,
  'Hinako',
  'JAPANESE',
  'Write your reply in Japanese.'
);


