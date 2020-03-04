package main

const (
	insertWordQuery = `
INSERT INTO words
    (word, letters)
VALUES ($1, $2)
ON CONFLICT DO NOTHING;

`

	selectAnagramsQuery = `
SELECT word
FROM words
WHERE letters = $1
  AND word != $2;
`
)

func insertWords(words []string, letters []string) error {

	var err error
	for i := range words {
		_, err = conn.Exec(insertWordQuery, words[i], letters[i])
		if err != nil {
			return err
		}
	}
	return nil
}

func searchForAnagram(letters, word string) ([]string, error) {
	var words []string

	err := conn.Select(&words, selectAnagramsQuery, letters, word)
	return words, err
}
