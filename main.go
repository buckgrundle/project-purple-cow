package main

import (
	"github.com/gofiber/fiber/v2"
	ssl_checker "project-purple-cow/ssl-checker"
)

func main() {
	server := fiber.New(fiber.Config{})

	server.Get("/ssl-checker", func(c *fiber.Ctx) error {
		resp, err := ssl_checker.SSLChecker(c.Query("host"))
		if err != nil {
			return err
		}
		return c.JSON(resp)
	})

	if err := server.Listen(":3000"); err != nil {
		panic(err)
	}
}
