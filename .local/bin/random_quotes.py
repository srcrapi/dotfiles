import random


def bold_string(string: str) -> str:
    return f"\033[1m{string}\033[0m"


def main():
    quotes = {
        "Some Reddit User": [
            "Ryo Yamada is the most important person in the world for me.",
            "The Weeds have given me hope in times of starvation.",
            "The bass gave me tranquility in times of disarray.",
            "Her wisdom guided me to success in times of stalemates.",
            "Ryo Yamada is my Saviour, and that's why I worship her 🌿🙏",
        ],
        "Ryo Yamada": [
            "Abandoning your uniqueness is equivalent to dying",
            "But won't it be hilarious if a normie sings that?",
        ],
    }

    author = random.choice(list(quotes.keys()))
    bold_author = bold_string(author)
    quote = quotes[author]
    quote = random.choice(quote)

    out = f'"{quote}" by {author}'

    with open("/tmp/out_random_quotes.txt", "w") as f:
        f.write(out)


if __name__ == "__main__":
    main()
