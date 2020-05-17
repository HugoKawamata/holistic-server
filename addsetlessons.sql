INSERT INTO set_lessons (content, title, titleScreenImage)
VALUES ('HIRAGANA_A', 'Hiragana Lesson 1', 'https://res.cloudinary.com/holistic-japanese/image/upload/v1587262008/lessons/hiragana-a/title.png'),
 ('HIRAGANA_KA', 'Hiragana Lesson 2', 'https://res.cloudinary.com/holistic-japanese/image/upload/v1587262008/lessons/hiragana-ka/title.png'),
 ('HIRAGANA_GA', 'Hiragana Lesson 2 - Bonus Round', 'https://res.cloudinary.com/holistic-japanese/image/upload/v1587262008/lessons/hiragana-ga/title.png'),
 ('HIRAGANA_SA', 'Hiragana Lesson 3', 'https://res.cloudinary.com/holistic-japanese/image/upload/v1587262008/lessons/hiragana-sa/title.png'),
 ('HIRAGANA_ZA', 'Hiragana Lesson 3 - Bonus Round', 'https://res.cloudinary.com/holistic-japanese/image/upload/v1587262008/lessons/hiragana-za/title.png'),
 ('HIRAGANA_TA', 'Hiragana Lesson 4', 'https://res.cloudinary.com/holistic-japanese/image/upload/v1587262008/lessons/hiragana-ta/title.png'),
 ('HIRAGANA_DA', 'Hiragana Lesson 4 - Bonus Round', 'https://res.cloudinary.com/holistic-japanese/image/upload/v1587262008/lessons/hiragana-da/title.png'),
 ('HIRAGANA_NA', 'Hiragana Lesson 4', 'https://res.cloudinary.com/holistic-japanese/image/upload/v1587262008/lessons/hiragana-na/title.png'),
 ('HIRAGANA_N', 'Hiragana Lesson 4 - Bonus Round', 'https://res.cloudinary.com/holistic-japanese/image/upload/v1587262008/lessons/hiragana-n/title.png');
INSERT INTO set_lessons (content, title, titleScreenImage)
VALUES ('HIRAGANA_HA', 'Hiragana Lesson 6', 'https://res.cloudinary.com/holistic-japanese/image/upload/v1587262008/lessons/hiragana-ha/title.png'),
 ('HIRAGANA_BA', 'Hiragana Lesson 6 - Bonus Round', 'https://res.cloudinary.com/holistic-japanese/image/upload/v1587262008/lessons/hiragana-ba/title.png'),
 ('HIRAGANA_MA', 'Hiragana Lesson 7', 'https://res.cloudinary.com/holistic-japanese/image/upload/v1587262008/lessons/hiragana-ma/title.png'),
 ('HIRAGANA_WA', 'Hiragana Lesson 7 - Bonus Round', 'https://res.cloudinary.com/holistic-japanese/image/upload/v1587262008/lessons/hiragana-wa/title.png'),
 ('HIRAGANA_YA', 'Hiragana Lesson 8', 'https://res.cloudinary.com/holistic-japanese/image/upload/v1587262008/lessons/hiragana-ya/title.png'),
 ('HIRAGANA_LYA', 'Hiragana Lesson 8 - Bonus Round', 'https://res.cloudinary.com/holistic-japanese/image/upload/v1587262008/lessons/hiragana-lya/title.png'),
 ('HIRAGANA_RA', 'Hiragana Lesson 9', 'https://res.cloudinary.com/holistic-japanese/image/upload/v1587262008/lessons/hiragana-ra/title.png'),
 ('HIRAGANA_PA', 'Hiragana Lesson 9 - Bonus Round', 'https://res.cloudinary.com/holistic-japanese/image/upload/v1587262008/lessons/hiragana-pa/title.png');

INSERT INTO set_lessons (id, title, image, unlocks_ids, course_id)
VALUES ('GMR_PARTICLE_WA', 'Talking about yourself', 'https://res.cloudinary.com/holistic-japanese/image/upload/v1587262008/lessons/katakana-1/title.png', '', 'GRAMMAR_1');

INSERT INTO courses (id, title)
VALUES ('GRAMMAR_1', 'Very Basic Conversation')

INSERT INTO lectures (set_lesson_id, title, text, image, position)
VALUES (
  3,
  'What is a "voiced" consonant?',
  'A voiced consonant is a consonant that you need to move your vocal cords to make.',
  'https://res.cloudinary.com/holistic-japanese/image/upload/v1587262011/lessons/hiragana-ga/lecture-1.png',
  'PRETEST'
),
(
  3,
  'What is a "voiced" consonant?',
  'For example, K is unvoiced, and G is voiced. G is actually the same as K, with vocal cords added.',
  'https://res.cloudinary.com/holistic-japanese/image/upload/v1587262011/lessons/hiragana-ga/lecture-2.png',
  'PRETEST'
),
(
  3,
  'What is a "voiced" consonant?',
  'You can try it yourself! Put your hand on your throat and make K and G sounds.',
  'https://res.cloudinary.com/holistic-japanese/image/upload/v1587262011/lessons/hiragana-ga/lecture-3.png',
  'PRETEST'
),
(
  3,
  'The TenTen',
  'In Japanese, you can make a hiragana''s consonant part voiced by adding a TenTen',
  'https://res.cloudinary.com/holistic-japanese/image/upload/v1587262011/lessons/hiragana-ga/lecture-4.png',
  'PRETEST'
),
(
  3,
  'The TenTen',
  'In this lesson, we''ll learn words with the "ga" set. That''s the "ka" set plus TenTens.',
  'https://res.cloudinary.com/holistic-japanese/image/upload/v1587262011/lessons/hiragana-ga/lecture-5.png',
  'PRETEST'
);


INSERT INTO lectures (set_lesson_id, title, text, image, position)
VALUES (
  5,
  'The Za Set',
  'Remember, TenTens can be added to hiragana to make the consonant part "voiced".',
  'https://res.cloudinary.com/holistic-japanese/image/upload/v1587262011/lessons/hiragana-za/lecture-1.png',
  'PRETEST'
),
(
  5,
  'The Za Set',
  'The "sa" set can also have a TenTen attached, which turns an S sound into a Z sound.',
  'https://res.cloudinary.com/holistic-japanese/image/upload/v1587262011/lessons/hiragana-za/lecture-2.png',
  'PRETEST'
),
(
  5,
  'The Za Set',
  'The one exception, of course, is "し" (shi). Shi becomes *ji*. Let''s get started!',
  'https://res.cloudinary.com/holistic-japanese/image/upload/v1587262011/lessons/hiragana-za/lecture-3.png',
  'PRETEST'
),
(
  5,
  'The Consonant Doubler',
  'Sorry, just one more thing. This little character "っ" doubles consonant sounds.',
  'https://res.cloudinary.com/holistic-japanese/image/upload/v1587262011/lessons/hiragana-za/lecture-4.png',
  'BEFORE_THIRD'
),
(
  5,
  'The Consonant Doubler',
  'It doesn''t make any sound on its own, but it extends the consonant sound of the next hiragana.',
  'https://res.cloudinary.com/holistic-japanese/image/upload/v1587262011/lessons/hiragana-za/lecture-5.png',
  'BEFORE_THIRD'
),
(
  5,
  'The Consonant Doubler',
  'It''s hard to explain it fully here. All you need to know is that to write it, you write a second consonant.',
  'https://res.cloudinary.com/holistic-japanese/image/upload/v1587262011/lessons/hiragana-ga/lecture-6.png',
  'BEFORE_THIRD'
),
(
  5,
  'The Consonant Doubler',
  'If you''d like to know more, it might be worth checking out some YouTube videos that explain it.',
  'https://res.cloudinary.com/holistic-japanese/image/upload/v1587262011/lessons/hiragana-ga/lecture-7.png',
  'BEFORE_THIRD'
);

INSERT INTO lectures (set_lesson_id, title, text, image, position)
VALUES (
  6,
  'The Ta Set',
  'The fourth set of hiragana is the "ta" set, which is the trickiest set of all.',
  'https://res.cloudinary.com/holistic-japanese/image/upload/v1587262011/lessons/hiragana-ta/lecture-1.png',
  'PRETEST'
),
(
  6,
  'The Ta Set',
  'Instead of "ti" it''s "chi", and instead of "tu" it''s "tsu"',
  'https://res.cloudinary.com/holistic-japanese/image/upload/v1587262011/lessons/hiragana-ta/lecture-2.png',
  'PRETEST'
),
(
  6,
  'Tsu?',
  'That''s right, this character "つ" is "tsu". When it''s small, it doubles consonants, but full sized it''s a letter on its own',
  'https://res.cloudinary.com/holistic-japanese/image/upload/v1587262011/lessons/hiragana-ta/lecture-3.png',
  'PRETEST'
),
(
  6,
  'Tsu?',
  'Here they are side by side, so you can see the difference: "つっ".',
  'https://res.cloudinary.com/holistic-japanese/image/upload/v1587262011/lessons/hiragana-ta/lecture-4.png',
  'PRETEST'
);

INSERT INTO lectures (set_lesson_id, title, text, image, position)
VALUES (
  7,
  'Ta Set + TenTens',
  'The "ta" set is the second last set that can have TenTens added, but it''s a bit different because of "chi" and "tsu".',
  'https://res.cloudinary.com/holistic-japanese/image/upload/v1587262011/lessons/hiragana-da/lecture-1.png',
  'PRETEST'
),
(
  7,
  'Ta Set + TenTens',
  'The T sound in the normal ones ("ta", "te" and "to") becomes a D sound.',
  'https://res.cloudinary.com/holistic-japanese/image/upload/v1587262011/lessons/hiragana-da/lecture-2.png',
  'PRETEST'
),
(
  7,
  'Ta Set + TenTens',
  '"chi" and "tsu" technically can have TenTens, but it''s quite rare to see them. (They become second versions of "ji" and "zu")',
  'https://res.cloudinary.com/holistic-japanese/image/upload/v1587262011/lessons/hiragana-da/lecture-3.png',
  'PRETEST'
),
(
  7,
  'Ta Set + TenTens',
  'For now, you can safely assume that they never get TenTens, so there''s only 3 new characters in this lesson!',
  'https://res.cloudinary.com/holistic-japanese/image/upload/v1587262011/lessons/hiragana-da/lecture-4.png',
  'PRETEST'
);

INSERT INTO lectures (set_lesson_id, title, text, image, position)
VALUES (
  8,
  'The Na Set',
  'There aren''t any strange exceptions or new rules in the "na" set! Enjoy the lesson.',
  'https://res.cloudinary.com/holistic-japanese/image/upload/v1587262011/lessons/hiragana-na/lecture-1.png',
  'PRETEST'
);


INSERT INTO lectures (set_lesson_id, title, text, image, position)
VALUES (
  9,
  'The Na Set Bonus Round',
  '"n" is already a voiced consonant, so letters in the "na" line cannot have a TenTen. This bonus round is different.',
  'https://res.cloudinary.com/holistic-japanese/image/upload/v1587262011/lessons/hiragana-n/lecture-1.png',
  'PRETEST'
),
(
  9,
  'The Letter N',
  'In this lesson, you''ll learn a new letter, "ん" (n). This is special letter: It''s the only Japanese letter that represents a single consonant, by itself.',
  'https://res.cloudinary.com/holistic-japanese/image/upload/v1587262011/lessons/hiragana-n/lecture-2.png',
  'PRETEST'
),
(
  9,
  'The Letter N',
  'Since it''s only one new letter, we''ll cover three new, useful words which use it.',
  'https://res.cloudinary.com/holistic-japanese/image/upload/v1587262011/lessons/hiragana-n/lecture-3.png',
  'PRETEST'
);

INSERT INTO lectures (set_lesson_id, title, text, image, position)
VALUES (
  10,
  'The Ha Set',
  'The sixth hiragana set is the "ha" set. It only has one tricky character.',
  'https://res.cloudinary.com/holistic-japanese/image/upload/v1587262011/lessons/hiragana-ha/lecture-1.png',
  'PRETEST'
),
(
  10,
  'Fu? Hu? Fhu?',
  'The tricky one is written as "fu", but it''s pronounced more like "fhu". It''s a combination of the H and F sounds.',
  'https://res.cloudinary.com/holistic-japanese/image/upload/v1587262011/lessons/hiragana-ha/lecture-2.png',
  'PRETEST'
);


INSERT INTO lectures (set_lesson_id, title, text, image, position)
VALUES (
  11,
  'Back to TenTens',
  'The "ha" set is the last set that can have TenTens attached. When it does, it transforms the sound from "H" to "B".',
  'https://res.cloudinary.com/holistic-japanese/image/upload/v1587262011/lessons/hiragana-ba/lecture-1.png',
  'PRETEST'
),
(
  11,
  'What About Fu?',
  'Even though "ふ" is an exception, it gets changed to "bu", just like the rest of the set.',
  'https://res.cloudinary.com/holistic-japanese/image/upload/v1587262011/lessons/hiragana-ba/lecture-2.png',
  'PRETEST'
);


INSERT INTO lectures (set_lesson_id, title, text, image, position)
VALUES (
  12,
  'The Ma Set',
  'The seventh set of hiragana is the "ma" set. Only 3 more to go!',
  'https://res.cloudinary.com/holistic-japanese/image/upload/v1587262011/lessons/hiragana-ma/lecture-1.png',
  'PRETEST'
),
(
  12,
  'The Ma Set',
  'Just like the "な" set, it doesn''t have any tricky characters. Enjoy!',
  'https://res.cloudinary.com/holistic-japanese/image/upload/v1587262011/lessons/hiragana-ma/lecture-2.png',
  'PRETEST'
);

INSERT INTO lectures (set_lesson_id, title, text, image, position)
VALUES (
  13,
  'The Wa "Set"',
  'This bonus round is all about the "wa" set, although it''s not much of a set.',
  'https://res.cloudinary.com/holistic-japanese/image/upload/v1587262011/lessons/hiragana-wa/lecture-1.png',
  'PRETEST'
),
(
  13,
  'The Wa Set',
  'There are only "two" characters in the set, and one of them isn''t even used in words (it''s more like a punctuation mark).',
  'https://res.cloudinary.com/holistic-japanese/image/upload/v1587262011/lessons/hiragana-wa/lecture-2.png',
  'PRETEST'
),
(
  13,
  'The Wa Set',
  'There''s "wa", which is the real character, and "wo", which is the weird, semi-fake character.',
  'https://res.cloudinary.com/holistic-japanese/image/upload/v1587262011/lessons/hiragana-wa/lecture-3.png',
  'PRETEST'
),
(
  13,
  'The Wa Set',
  'It doesn''t make much sense now, but once you start learning how to make Japanese sentences, "wo" will become very important!',
  'https://res.cloudinary.com/holistic-japanese/image/upload/v1587262011/lessons/hiragana-wa/lecture-4.png',
  'PRETEST'
);

INSERT INTO lectures (set_lesson_id, title, text, image, position)
VALUES (
  14,
  'The Ya Set',
  'We''re getting to the end of the hiragana sets, and they do get a bit strange from here on.',
  'https://res.cloudinary.com/holistic-japanese/image/upload/v1587262011/lessons/hiragana-ya/lecture-1.png',
  'PRETEST'
),
(
  14,
  'The Ya Set',
  'This set is the "ya" set, but it looks like it''s missing two characters.',
  'https://res.cloudinary.com/holistic-japanese/image/upload/v1587262011/lessons/hiragana-ya/lecture-2.png',
  'PRETEST'
),
(
  14,
  'The Ya Set',
  'Japanese doesn''t actually have the yi and ye sounds. There are only three characters in this set.',
  'https://res.cloudinary.com/holistic-japanese/image/upload/v1587262011/lessons/hiragana-ya/lecture-3.png',
  'PRETEST'
);

INSERT INTO lectures (set_lesson_id, title, text, image, position)
VALUES (
  15,
  'Little Ya, Yu, and Yo',
  'Just like "つ", "ya", "yu" and "yo" can also become smaller to do something different.',
  'https://res.cloudinary.com/holistic-japanese/image/upload/v1587262011/lessons/hiragana-lya/lecture-1.png',
  'PRETEST'
),
(
  15,
  'Little Ya, Yu and Yo',
  'They can go after any hiragana that ends in "i" ("shi", "chi", "hi", "ni", etc.) to modify the sound.',
  'https://res.cloudinary.com/holistic-japanese/image/upload/v1587262011/lessons/hiragana-lya/lecture-2.png',
  'PRETEST'
),
(
  15,
  'Little Ya, Yu and Yo',
  'For example, "ki" + "ya" = "kya". There are lots of combinations, so they''re not all listed here.',
  'https://res.cloudinary.com/holistic-japanese/image/upload/v1587262011/lessons/hiragana-lya/lecture-3.png',
  'PRETEST'
),
(
  15,
  'Little Ya, Yu and Yo',
  'Once you get the hang of how they combine, it will feel pretty intuitive!',
  'https://res.cloudinary.com/holistic-japanese/image/upload/v1587262011/lessons/hiragana-lya/lecture-3.png',
  'PRETEST'
);

INSERT INTO lectures (set_lesson_id, title, text, image, position)
VALUES (
  16,
  'The Ra Set',
  'This is the final set of hiragana! Well done for making it all the way here.',
  'https://res.cloudinary.com/holistic-japanese/image/upload/v1587262011/lessons/hiragana-ra/lecture-1.png',
  'PRETEST'
),
(
  16,
  'The Ra Set',
  'The "ra" set is hard for English speakers to pronounce, in the same way the English "l" and "r" are hard for Japanese people',
  'https://res.cloudinary.com/holistic-japanese/image/upload/v1587262011/lessons/hiragana-ra/lecture-2.png',
  'PRETEST'
),
(
  16,
  'The Ra Set',
  'It''s definitely worth checking out some videos to practice your pronunciation.',
  'https://res.cloudinary.com/holistic-japanese/image/upload/v1587262011/lessons/hiragana-ra/lecture-3.png',
  'PRETEST'
),
(
  16,
  'The Ra Set',
  'Other than that, this set is pretty normal. Just one more bonus lesson after this!',
  'https://res.cloudinary.com/holistic-japanese/image/upload/v1587262011/lessons/hiragana-ra/lecture-4.png',
  'PRETEST'
);


INSERT INTO lectures (set_lesson_id, title, text, image, position)
VALUES (
  17,
  'Return To The Ha Set',
  'The "は" set has one last trick up its sleeve, besides the TenTen.',
  'https://res.cloudinary.com/holistic-japanese/image/upload/v1587262011/lessons/hiragana-pa/lecture-1.png',
  'PRETEST'
),
(
  17,
  'The Maru',
  'The Maru is sort of like the TenTen - it changes how hiragana is pronounced, but it only works with the "は" set.',
  'https://res.cloudinary.com/holistic-japanese/image/upload/v1587262011/lessons/hiragana-pa/lecture-2.png',
  'PRETEST'
),
(
  17,
  'The Maru',
  'When a hiragana from the "は" set has a Maru, its consonant sound changes from "H" to "P".',
  'https://res.cloudinary.com/holistic-japanese/image/upload/v1587262011/lessons/hiragana-pa/lecture-3.png',
  'PRETEST'
);
