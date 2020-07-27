New words: 難しい、日本語、いい

INSERT INTO words (japanese, hiragana, english, introduction, emoji)
VALUES ('難しい', 'むずかしい', 'Difficult, hard', 'This word means "difficult" or "hard".', '‍😩'),
       ('日本語', 'にほんご', 'Japanese (language)', 'This word means "Japanese" as in the language. Notice how both にほんご and えいご (English) end in ご. That complex kanji means "language".', '🇯🇵'),
       ('いい', 'いい', 'Good', 'This word means "good", but it can also mean "fine", "ok", etc. It basically conveys positive emotion.', '👍');

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
  'GMR_MO_DESU',
  'YUJI_CHATTING',
  'HOSTEL_LOBBY',
  null,
  null,
  'Dogs are so cute.',
  'Cats are also cute/Cats are cute too/Cats are also cute, right?/Cats are cute too, right?',
  '猫.も　かわいい　です.ね。',
  'ねこ.も　かわいい　です.ね。',
  null,
  'J_SENTENCE',
  1,
  'You',
  'ENGLISH',
  'Translate Yuji''s reply (don''t worry about the ね at the end for now)'
),
(
  'GMR_MO_DESU',
  null,
  null,
  null,
  null,
  null,
  null,
  null,
  null,
  84,
  'J_WORD',
  8,
  null,
  'ROMAJI',
  null
),
(
  'GMR_MO_DESU',
  'HINAKO_EATING',
  'RESTAURANT',
  null,
  null,
  'What sushi is good here?',
  'Tuna and salmon are good/Tuna and salmon are delicious/The tuna and salmon are good/The tuna and salmon are delicious',
  '鮪.と　鮭.は　うまい　です.よ。',
  'まぐろ.と　しゃけ.は　うまい　です.よ。',
  null,
  'J_SENTENCE',
  3,
  'You (looking at restaurant menu)',
  'ENGLISH',
  'Translate Hinako''s reply (again, don''t worry about the よ particle at the end)'
),
(
  'GMR_MO_DESU',
  null,
  null,
  null,
  null,
  null,
  null,
  null,
  null,
  82,
  'J_WORD',
  4,
  null,
  'ROMAJI',
  null
),
(
  'GMR_WA_DESU_2',
  null,
  null,
  null,
  null,
  null,
  null,
  null,
  null,
  83,
  'J_WORD',
  5,
  null,
  'ROMAJI',
  null
),
(
  'GMR_MO_DESU',
  'YUJI_CHATTING',
  'HOSTEL_LOBBY',
  'まぁ、英語.は　難しい　です.ね。',
  'まぁ、えいご.は　むずかしい　です.ね。',
  'Man, English is hard.',
  '日本語.も　難しい　です/日本語.も　難しい　です.よ/にほんご.も　むずかしい　です/にほんご.も　むずかしい　です.よ/日本語.も　むずかしい　です・日本語.も　むずかしい　です.よ/にほんご.も　難しい　です/にほんご.も　難しい　です.よ',
  'Japanese is hard too.',
  null,
  null,
  'E_SENTENCE',
  6,
  'Yuji',
  'JAPANESE',
  'Write your reply in Japanese'
),
(
  'GMR_MO_DESU',
  'HINAKO_CHATTING',
  'TRAIN_STATION',
  'ここ.まで、日本.は　どう　です.か？',
  'ここ.まで、にほん.は　どう　です.か？',
  'What do you think of Japan so far?',
  '空港.と　駅.は　凄い　です/くうこう.と　えき.は　すごい　です/空港.と　えき.は　すごい　です/くうこう.と　駅.は　すごい　です/くうこう.と　えき.は　凄い　です/空港.と　駅.は　すごい　です/空港.と　えき.は　凄い　です/くうこう.と　駅.は　凄い　です',
  'The airport and the train station are amazing!',
  null,
  null,
  'E_SENTENCE',
  7,
  'Hinako',
  'JAPANESE',
  'Write your reply in Japanese.'
),
(
  'GMR_MO_DESU',
  'HINAKO_CHATTING',
  'HOSTEL_LOBBY',
  'ごめんね。ペンを頼んだことを知っているけど、鉛筆だけ見つけられた。',
  'ごめんね。ぺんをたのんだことをしっているけど、えんぴつだけみつけられた。',
  'Sorry. I know you asked for a pen, but I could only find a pencil.',
  '大丈夫　です。鉛筆.も　いい　です/だいじょうぶ　です。えんぴつ.も　いい　です/大丈夫　です。鉛筆.も　いい　です.よ/だいじょうぶ　です。えんぴつ.も　いい　です.よ/大丈夫　です。えんぴつ.も　いい　です/だいじょうぶ　です。鉛筆.も　いい　です/大丈夫　です。えんぴつ.も　いい　です.よ/大丈夫　です。えんぴつ.も　いい　です.よ',
  'It''s ok. A pencil is good too.',
  null,
  null,
  'E_SENTENCE',
  8,
  'Hinako',
  'JAPANESE',
  'Write your reply in Japanese'
);



INSERT INTO set_lessons (id, title, image, unlocks_ids, course_id, skill_level, time_estimate)
VALUES ('GMR_MO_DESU', 'And Also', 'todo: add image link', 'GMR_DESHITA', 'GRAMMAR_1', 'Beginner', 600);

INSERT INTO lectures (text, image, position, set_lesson_id, title)
VALUES (
  'Now you know how to describe anything using the "''Xは Yです''" pattern. In this lesson, you''ll learn how to describe multiple things at once.',
  'https://res.cloudinary.com/holistic-japanese/image/upload/v1595227831/lessons/grammar_1/gmr_wa_desu_2/lecture-2.png',
  'PRETEST',
  'GMR_MO_DESU',
  'Multiple Things'
),
(
  'We have some new "particles"! Remember, particles go at the end of a word and flag what the word''s role is in the sentence, like "は".',
  'https://res.cloudinary.com/holistic-japanese/image/upload/v1595821956/lessons/grammar_1/gmr_mo_desu/lecture-2.png',
  'PRETEST',
  'GMR_MO_DESU',
  'New Particles'
),
(
  'The particle "と" almost directly translates to "and". (But it can only be used to connect nouns, not adjectives or verbs)',
  'https://res.cloudinary.com/holistic-japanese/image/upload/v1595821707/lessons/grammar_1/gmr_mo_desu/lecture-3.png',
  'PRETEST',
  'GMR_MO_DESU',
  'Particle と'
),
(
  'For example, ''すし"と" おべんとうは おいしい です'' means ''Sushi "and" obento are delicious''.',
  'https://res.cloudinary.com/holistic-japanese/image/upload/v1595821707/lessons/grammar_1/gmr_mo_desu/lecture-3.png',
  'PRETEST',
  'GMR_MO_DESU',
  'Particle と'
),
(
  'The particle "も" almost directly translates to "also" or "too". It needs context to make sense though.',
  'https://res.cloudinary.com/holistic-japanese/image/upload/v1595822092/lessons/grammar_1/gmr_mo_desu/lecture-5.png',
  'PRETEST',
  'GMR_MO_DESU',
  'Particle も'
),
(
  'For example, if someone said ''すしは おいしいです'' (sushi is delicious), you could say ''おべんとうも おいしいです'' (obento is also delicious).',
  'https://res.cloudinary.com/holistic-japanese/image/upload/v1595822092/lessons/grammar_1/gmr_mo_desu/lecture-5.png',
  'PRETEST',
  'GMR_MO_DESU',
  'Particle も'
);