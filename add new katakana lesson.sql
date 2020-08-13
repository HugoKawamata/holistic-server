INSERT INTO set_lessons (content, title, image, unlocks_ids, course_id)
VALUES ('KATAKANA_1', 'Intro to Loanwords', '', 'KATAKANA');

INSERT INTO lectures (text, image, position, set_lesson_id, title)
VALUES (
  'You can think of Katakana as being similar to capital letters in English. It''s the same alphabet, just a different way of writing it.',
  'https://res.cloudinary.com/holistic-japanese/image/upload/v1597309298/lessons/katakana/katakana-1/lecture-1.png',
  'PRETEST',
  'KATAKANA_1',
  'Katakana - Japanese CAPSLOCK'
),(
  'Just like capitals, they tend to look less curvy and more angular, and are used to write sound effects like we do with ''"BANG!"'' and ''"SMASH!"''.',
  'https://res.cloudinary.com/holistic-japanese/image/upload/v1597309487/lessons/katakana/katakana-1/lecture-2.png',
  'PRETEST',
  'KATAKANA_1',
  'Katakana - Japanese CAPSLOCK'
),(
  'Also like capital letters, sometimes they look very similar to their hiragana version, and sometimes they look completely different.',
  'https://res.cloudinary.com/holistic-japanese/image/upload/v1597309764/lessons/katakana/katakana-1/lecture-3.png',
  'PRETEST',
  'KATAKANA_1',
  'Katakana - Japanese CAPSLOCK'
),(
  'In addition to writing sound effects, they''re usually used to write loanwords - words that have been taken from English or other languages.',
  'https://res.cloudinary.com/holistic-japanese/image/upload/v1597310487/lessons/katakana/katakana-1/lecture-4.png',
  'PRETEST',
  'KATAKANA_1',
  'Loanwords'
),(
  'Japan borrows a lot of words from English, which makes things a bit easier. Words like hot dog (hotto doggu) and apartment (apaato) are very common.',
  'https://res.cloudinary.com/holistic-japanese/image/upload/v1597310487/lessons/katakana/katakana-1/lecture-4.png',
  'PRETEST',
  'KATAKANA_1',
  'Loanwords'
),(
  'In this first lesson, you''ll learn 4 katakana (ko, hi, se, ru) and 4 commonly used Japanese words that started out as English words.',
  'https://res.cloudinary.com/holistic-japanese/image/upload/v1597310487/lessons/katakana/katakana-1/lecture-4.png',
  'PRETEST',
  'KATAKANA_1',
  'Loanwords'
);

INSERT INTO words (japanese, hiragana, english, introduction, emoji)
VALUES ('コーヒー', 'コーヒー', 'Coffee', 'This is coffee. Japanese doesn''t have a "fi" sound, so it''s "ko-hi-". The dash indicates a long vowel sound.', '☕️'),
       ('ビール', 'ビール', 'Beer', 'This is beer: "bi-ru". Just like hiragana, katakana can get TenTens to change sound. "Hi" turns to "bi".', '🍺'),
       ('ビル', 'ビル', 'Building', 'This is building, but it''s shortened to "biru". The only difference between this and "beer" is the long vowel dash!', '🏢'),
       ('セール', 'セール', 'Sale', 'This is sale: "se-ru". Notice how similar katakana セ and hiragana せ are.', '💸');