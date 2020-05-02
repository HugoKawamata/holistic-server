INSERT INTO set_lessons (content, title, titleScreenImage)
VALUES ('HIRAGANA_A', 'Hiragana Lesson 1', 'https://res.cloudinary.com/holistic-japanese/image/upload/v1587262008/lessons/hiragana-a/title.png'),
VALUES ('HIRAGANA_KA', 'Hiragana Lesson 2', 'https://res.cloudinary.com/holistic-japanese/image/upload/v1587262008/lessons/hiragana-ka/title.png'),
VALUES ('HIRAGANA_GA', 'Hiragana Lesson 2 - Bonus Round', 'https://res.cloudinary.com/holistic-japanese/image/upload/v1587262008/lessons/hiragana-ga/title.png'),
VALUES ('HIRAGANA_SA', 'Hiragana Lesson 3', 'https://res.cloudinary.com/holistic-japanese/image/upload/v1587262008/lessons/hiragana-sa/title.png'),
VALUES ('HIRAGANA_ZA', 'Hiragana Lesson 3 - Bonus Round', 'https://res.cloudinary.com/holistic-japanese/image/upload/v1587262008/lessons/hiragana-za/title.png'),
VALUES ('HIRAGANA_TA', 'Hiragana Lesson 4', 'https://res.cloudinary.com/holistic-japanese/image/upload/v1587262008/lessons/hiragana-ta/title.png'),
VALUES ('HIRAGANA_DA', 'Hiragana Lesson 4 - Bonus Round', 'https://res.cloudinary.com/holistic-japanese/image/upload/v1587262008/lessons/hiragana-da/title.png'),
VALUES ('HIRAGANA_NA', 'Hiragana Lesson 4', 'https://res.cloudinary.com/holistic-japanese/image/upload/v1587262008/lessons/hiragana-na/title.png'),
VALUES ('HIRAGANA_N', 'Hiragana Lesson 4 - Bonus Round', 'https://res.cloudinary.com/holistic-japanese/image/upload/v1587262008/lessons/hiragana-n/title.png');

INSERT INTO lectures (set_lesson_content, dialogue, image, position)
VALUES (
  'HIRAGANA_A',
  'Hiragana consists of 5 characters that represent vowel sounds (A, I, U, E, O) and 40 characters that represent a consonant-plus-a-vowel-sound (K, S, T, N, H, M, Y, ɾ, and W), as well as a single lone consonant (N).', 
  'https://res.cloudinary.com/holistic-japanese/image/upload/v1587262011/lessons/hiragana-a/lecture-1.png',
  'PRETEST'
),
VALUES (
  'HIRAGANA_A',
  'Because the characters represent syllables, they are always pronounced the same. Unlike in English, where "same" is pronouned with a long A sound, the Japanese "さめ" 🦈 (sa・me) is pronounced "sah-meh".',
  'https://res.cloudinary.com/holistic-japanese/image/upload/v1587262011/lessons/hiragana-a/lecture-2.png',
  'PRETEST'
),
VALUES (
  'HIRAGANA_KA',
  'In this lesson, we''ll take a look at the first line of hiragana that combine consonant and vowel sounds (which is almost all the other hiragana besides あいうえお). It''s the "ka" line!',
  'https://res.cloudinary.com/holistic-japanese/image/upload/v1587262011/lessons/hiragana-ka/lecture-1.png',
  'PRETEST'
),
VALUES (
  'HIRAGANA_KA',
  'After this lesson, there will be a special bonus round. You won''t need to learn any new Japanese characters, but you will learn 5 new letters. Cryptic enough for you? 😉 Let''s get started!',
  'https://res.cloudinary.com/holistic-japanese/image/upload/v1587262011/lessons/hiragana-ka/lecture-2.png',
  'PRETEST'
),
VALUES (
  'HIRAGANA_GA',
  'Welcome to the か line bonus round!'
  'https://res.cloudinary.com/holistic-japanese/image/upload/v1587262011/lessons/hiragana-ga/lecture-1.png',
  'PRETEST'
),
VALUES (
  'HIRAGANA_GA',
  'You may have noticed that on the regular hiragana chart, there aren''t that many consonant sounds: K, S, T, N, M, Y, R and W. Only 8 compared to English''s 21. However, there are actually quite a few more, hiding away...',
  'https://res.cloudinary.com/holistic-japanese/image/upload/v1587262011/lessons/hiragana-ga/lecture-2.png',
  'PRETEST'
),
VALUES (
  'HIRAGANA_GA',
  'There''s a special little symbol you can add to about half of the hiragana, called a "tenten". It looks like little quotation marks in the top right corner, and it changes the consonant sound in a very special way.',
  'https://res.cloudinary.com/holistic-japanese/image/upload/v1587262011/lessons/hiragana-ga/lecture-3.png',
  'PRETEST'
),
VALUES (
  'HIRAGANA_GA',
  'They only appear on _non-voiced_ consonant sounds (K, S, T, and H), and change it to a _voiced_ consonant (G, Z, D, and B, respectively). Non-voiced means you don''t vibrate your vocal cords when you say it - try saying "ka" with your hand on your throat. You won''t feel your vocal cords until you say the "a" part.',
  'https://res.cloudinary.com/holistic-japanese/image/upload/v1587262011/lessons/hiragana-ga/lecture-4.png',
  'PRETEST'
),
VALUES (
  'HIRAGANA_GA',
  'When you say "ga", your mouth actually makes the same movements as when you say "ka". The only difference is that you use your vocal cords for the "g" sound. Try it out yourself!',
  'https://res.cloudinary.com/holistic-japanese/image/upload/v1587262011/lessons/hiragana-ga/lecture-5.png',
  'PRETEST'
),
VALUES (
  'HIRAGANA_GA',
  'Isn''t Japanese cool!? Anyway, let''s start the lesson. We''ll be covering the か line again, but with words that use tentens.',
  'https://res.cloudinary.com/holistic-japanese/image/upload/v1587262011/lessons/hiragana-ga/lecture-6.png',
  'PRETEST'
),
VALUES (
  'HIRAGANA_SA',
  'In this lesson, we''ll be going over the third hiragana line, the "sa" line'
  'https://res.cloudinary.com/holistic-japanese/image/upload/v1587262011/lessons/hiragana-sa/lecture-1.png',
  'PRETEST'
),
VALUES (
  'HIRAGANA_SA',
  'Now, this line has one tricky letter in it. You might have assumed the letters would be "sa", "si", "su", "se", "so", but "si" is a bit different...',
  'https://res.cloudinary.com/holistic-japanese/image/upload/v1587262011/lessons/hiragana-sa/lecture-2.png',
  'PRETEST'
),
VALUES (
  'HIRAGANA_SA',
  'Instead of "si", it''s "shi". After all, we couldn''t have "sushi" without the "shi" sound!',
  'https://res.cloudinary.com/holistic-japanese/image/upload/v1587262011/lessons/hiragana-sa/lecture-3.png',
  'PRETEST'
),
VALUES (
  'HIRAGANA_ZA',
  'Welcome to the さ line bonus round!',
  'https://res.cloudinary.com/holistic-japanese/image/upload/v1587262011/lessons/hiragana-za/lecture-1.png',
  'PRETEST'
),
VALUES (
  'HIRAGANA_ZA',
  'I''m sure you remember how tentens work - they make an un-voiced consonant sound into a voiced consonant sound. When it comes to "S" sounds, they become "Z" sounds.',
  'https://res.cloudinary.com/holistic-japanese/image/upload/v1587262011/lessons/hiragana-za/lecture-2.png',
  'PRETEST'
),
VALUES (
  'HIRAGANA_ZA',
  'There are a couple other little things I want to cover in this lesson, but we''ll get to those. Let''s just jump right in.',
  'https://res.cloudinary.com/holistic-japanese/image/upload/v1587262011/lessons/hiragana-za/lecture-3.png',
  'PRETEST'
),
VALUES (
  'HIRAGANA_ZA',
  'Sorry, I just want to quickly introduce something new. This little character is a consonant "doubler". It makes the following consonant sound take a bit longer to say.',
  'https://res.cloudinary.com/holistic-japanese/image/upload/v1587262011/lessons/hiragana-za/lecture-4.png',
  'PRETEST'
),
VALUES (
  'HIRAGANA_ZA',
  'It might take some getting used to, to be able to hear the difference, but all you need to know for now is that it clones the following consonant.',
  'https://res.cloudinary.com/holistic-japanese/image/upload/v1587262011/lessons/hiragana-za/lecture-5.png',
  'PRETEST'
),
VALUES (
  'HIRAGANA_TA',
  'In this lesson, we''ll cover the hiragana "ta" line.',
  'https://res.cloudinary.com/holistic-japanese/image/upload/v1587262011/lessons/hiragana-ta/lecture-1.png',
  'PRETEST'
),
VALUES (
  'HIRAGANA_TA',
  'Remember how the さ line had a weird one (し)? Well, this line has two weird ones... After this there''s only one more exception, I promise!',
  'https://res.cloudinary.com/holistic-japanese/image/upload/v1587262011/lessons/hiragana-ta/lecture-2.png',
  'PRETEST'
),
VALUES (
  'HIRAGANA_TA',
  'The weird ones are ち・chi and つ・tsu.'
  'https://res.cloudinary.com/holistic-japanese/image/upload/v1587262011/lessons/hiragana-ta/lecture-3.png',
  'PRETEST'
),
VALUES (
  'HIRAGANA_TA',
  'I know what you''re thinking: "Wait a second, that''s not tsu, that the consonant doubler!". You''re right! When つ is little (っ), it works as the consonant doubler instead.'
  'https://res.cloudinary.com/holistic-japanese/image/upload/v1587262011/lessons/hiragana-ta/lecture-4.png',
  'PRETEST'
),