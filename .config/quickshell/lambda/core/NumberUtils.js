function toRoman(num) {
    if (num <= 0) return num

    const map = [
        { v: 1000, s: "M" },
        { v: 900, s: "CM" },
        { v: 500, s: "D" },
        { v: 400, s: "CD" },
        { v: 100, s: "C" },
        { v: 90, s: "XC" },
        { v: 50, s: "L" },
        { v: 40, s: "XL" },
        { v: 10, s: "X" },
        { v: 9, s: "IX" },
        { v: 5, s: "V" },
        { v: 4, s: "IV" },
        { v: 1, s: "I" }
    ]

    let result = ""
    let n = num

    for (let i = 0; i < map.length; i++) {
        while (n >= map[i].v) {
            result += map[i].s
            n -= map[i].v
        }
    }

    return result
}