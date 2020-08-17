INSERT INTO set_lessons (id, title, image, unlocks_ids, course_id, skill_level, time_estimate)
VALUES ('KATAKANA_11', 'Shirt, Ramune and more', '', 'NEXT_COURSE', 'KATAKANA', 'Beginner', 420);

INSERT INTO lectures (text, image, position, set_lesson_id, title)
VALUES (
  'In this lesson, you''ll learn two katakana that might look a bit familiar: "シ" (shi) and "ソ" (so).',
  'https://res.cloudinary.com/holistic-japanese/image/upload/v1597629604/lessons/katakana/katakana-9/lecture-1.png',
  'PRETEST',
  'KATAKANA_9',
  'Very Similar Katakana'
),(
  'They look very similar to "ツ" (tsu) and "ン" (n). Here''s a little tip to help tell them apart (it''s still hard though).',
  'https://res.cloudinary.com/holistic-japanese/image/upload/v1597629568/lessons/katakana/katakana-9/lecture-2.png',
  'PRETEST',
  'KATAKANA_9',
  'Very Similar Katakana'
),(
  '"shi" and "n" are the same, just with one extra dash. And "tsu" and "so" are also the same, with one extra dash.',
  'https://res.cloudinary.com/holistic-japanese/image/upload/v1597629709/lessons/katakana/katakana-9/lecture-3.png',
  'PRETEST',
  'KATAKANA_9',
  'Shi & N vs Tsu & So'
),(
  'The difference is how they are handwritten: the pen strokes in "tsu" and "so" go downwards, while "shi" and "n" go to the right.',
  'https://res.cloudinary.com/holistic-japanese/image/upload/v1597630090/lessons/katakana/katakana-9/lecture-4.png',
  'PRETEST',
  'KATAKANA_9',
  'Shi & N vs Tsu & So'
),(
  'On a computer, the difference is a bit harder to see. If you practise reading enough, you''ll be able to tell them apart easily!',
  'https://res.cloudinary.com/holistic-japanese/image/upload/v1597630090/lessons/katakana/katakana-9/lecture-4.png',
  'PRETEST',
  'KATAKANA_9',
  'Shi & N vs Tsu & So'
);

INSERT INTO words (japanese, hiragana, english, introduction, emoji, set_lesson_id)
VALUES ('ボーナス', 'ボーナス', 'Bonus', 'This means "bonus". The new katakana is "na".', '🏅', 'KATAKANA_11'),
       ('ヌードル', 'ヌードル', 'Noodle', 'This means "noodle", but Japanese also has a native word for it as well. The katakana "nu" is quite rare.', '🍝', 'KATAKANA_11'),
       ('ラムネ', 'ラムネ', 'Ramune', '"Ramune" is a Japanese lemonade that is sealed with a marble (AKA marble soda). It comes from a corruption of the English "lemonade".', '🥤', 'KATAKANA_11'),
       ('シャツ', 'シャツ', 'Shirt', 'This means "shirt". The new, small katakana is "ya", which combines with "shi" to make "sha". Careful of the "tsu", it''s not the same as "shi"!', '👕', 'KATAKANA_11');

       ('サラダ', 'サラダ', 'Salad', 'This is "salad". The new letter is "ta" with a TenTen.', '🥗', 'KATAKANA_6');