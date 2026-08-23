// Go: パッケージ宣言、構造体、インターフェース、ゴルーチン、チャネル、エラーハンドリング、defer の確認用
package main

import (
	"context"
	"fmt"
	"sync"
	"time"
)

const (
	ThemeName    string = "edo-nezu-theme"
	DefaultScale int    = 255
)

// TraditionalColor は色情報を保持する構造体
type TraditionalColor struct {
	ID   int    `json:"id"`
	Name string `json:"name"`
	Hex  string `json:"hex"`
}

// ColorProcessor は色情報処理インターフェース
type ColorProcessor interface {
	Process(ctx context.Context) (string, error)
}

func (tc *TraditionalColor) Process(ctx context.Context) (string, error) {
	select {
	case <-ctx.Done():
		return "", ctx.Err()
	default:
		return fmt.Sprintf("Processing: %s (%s)", tc.Name, tc.Hex), nil
	}
}

func main() {
	ctx, cancel := context.WithTimeout(context.Background(), 2*time.Second)
	defer cancel()

	colors := []TraditionalColor{
		{ID: 1, Name: "白鼠", Hex: "#dcdddd"},
		{ID: 2, Name: "舛花色", Hex: "#567a98"},
		{ID: 3, Name: "老竹色", Hex: "#6a8372"},
	}

	resultChan := make(chan string, len(colors))
	var wg sync.WaitGroup

	for _, c := range colors {
		wg.Add(1)
		go func(color TraditionalColor) {
			defer wg.Done()
			msg, err := color.Process(ctx)
			if err != nil {
				return
			}
			resultChan <- msg
		}(c)
	}

	wg.Wait()
	close(resultChan)

	for res := range resultChan {
		fmt.Println(res)
	}
}
