package main

const (
	insertWordQuery = `
INSERT INTO words
    (word, letters)
VALUES ($1, $2)
ON CONFLICT DO NOTHING;

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
