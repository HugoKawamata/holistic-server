INSERT INTO set_lessons (id, title, image, unlocks_ids, course_id, skill_level, time_estimate)
VALUES ('GMR_DESHITA', 'Past Tense', 'todo: add image link', 'GMR_JANAI', 'GRAMMAR_1', 'Beginner', 600);

INSERT INTO lectures (text, image, position, set_lesson_id, title)
VALUES (
  'Last time you learnt how to talk about multiple things at once. This lesson will cover how to use past tense.',
  'todo image',
  'PRETEST',
  'GMR_DESHITA',
  'Past Tense'
),
(
  'The past tense of です (desu) is でした (deshita). Notice how the す character only _half_-changed. It became a し (shi), but stayed in the S hiragana set.',
  'todo image',
  'PRETEST',
  'GMR_DESHITA',
  'Half Changing a Character'
),
(
  'Most past tense words in Japanese end in た. So it''s pretty easy to tell when something is past tense!',
  'todo image',
  'PRETEST',
  'GMR_DESHITA',
  'An Easy Shortcut'
),
(
  'That means that でした means "was". For a quick example, "''おいしい でした''" would mean "''It was delicious''".',
  'todo image',
  'PRETEST',
  'GMR_DESHITA',
  'Example'
);

X: "You went to New Zealand? How was it?"
A: "It was beautiful!"

X: "What was that sound?"
A: "It was a bird"

A: "What was the yakitori like?"
X: "It was delicious!"

A: "How was the show?"
X: "It was fun!"

INSERT INTO words (japanese, hiragana, english, introduction, emoji)
VALUES ('美しい', 'うつくしい', 'Beautiful', 'This means "beautiful".', '‍😍'),
       ('鳥', 'とり', 'Bird, chicken', 'This word means "bird", and sometimes more specifically, "chicken".', '🐓'),
       ('焼鳥', 'やきとり', 'Yakitori', '"Yakitori" is a Japanese dish, so it doesn''t have a translation. They''re grilled chicken skewers, and they''re so good!', '🍗'),
       ('楽しい', 'たのしい', 'Fun', 'This means "fun" or "enjoyable".', '😄');

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
  'GMR_DESHITA',
  null,
  null,
  null,
  null,
  null,
  null,
  null,
  null,
  86,
  'J_WORD',
  1,
  null,
  'ROMAJI',
  null
),
(
  'GMR_DESHITA',
  'YUJI_CHATTING',
  'HOSTEL_LOBBY',
  null,
  null,
  'You''ve been to New Zealand? How was it?',
  'It was beautiful/Beautiful',
  '美しい　でした。',
  'うつくしい　でした。',
  null,
  'J_SENTENCE',
  2,
  'You',
  'ENGLISH',
  'Translate Yuji''s reply'
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
  87,
  'J_WORD',
  3,
  null,
  'ROMAJI',
  null
),
(
  'GMR_DESHITA',
  'HINAKO_CHATTING',
  'TOKYO_STREET',
  null,
  null,
  'What was that?',
  'It was a bird/That was a bird/A bird',
  '鳥　でした',
  'とり　でした',
  null,
  'J_SENTENCE',
  4,
  'You (hearing a sound)',
  'ENGLISH',
  'Translate Hinako''s reply'
),
(
  'GMR_DESHITA',
  null,
  null,
  null,
  null,
  null,
  null,
  null,
  null,
  88,
  'J_WORD',
  5,
  null,
  'ROMAJI',
  null
),
(
  'GMR_DESHITA',
  'YUJI_CHATTING',
  'RESTAURANT',
  '焼鳥.は　どう　でした？',
  'やきとり.は　どう　でした？',
  'What was the yakitori like?',
  '焼鳥.は　美味しい　でした/やきとり.は　おいしい　でした/焼鳥.は　おいしい　でした/やきとり.は　美味しい　でした/焼き鳥.は　美味しい　でした/焼鳥.は　おいしい　でした/焼鳥.は　うまい　でした/やきとり.は　うまい　でした/焼き鳥.は　うまい　でした',
  'The yakitori was delicious.',
  null,
  null,
  'E_SENTENCE',
  6,
  'Yuji',
  'JAPANESE',
  'Write your reply in Japanese'
),
(
  'GMR_DESHITA',
  null,
  null,
  null,
  null,
  null,
  null,
  null,
  null,
  89,
  'J_WORD',
  7,
  null,
  'ROMAJI',
  null
),
(
  'GMR_DESHITA',
  'HINAKO_CHATTING',
  'HOSTEL_LOBBY',
  'コンサート.は　どう　でした.か？',
  'コンサート.は、どう　でした.か？',
  'How was the concert?',
  '楽しい　でした/たのしい　でした',
  'It was fun!',
  null,
  null,
  'E_SENTENCE',
  8,
  'Hinako',
  'JAPANESE',
  'Write your reply in Japanese.'
);


