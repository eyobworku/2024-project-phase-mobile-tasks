const { add } = require("./calculator");

describe("add", () => {
  test("should add two positive numbers correctly", () => {
    expect(add(2, 3)).toBe(5);
  });

  // New test for the new feature
  test("should concatenate two strings", () => {
    expect(add("hello", " world")).toBe("hello world");
  });
});
