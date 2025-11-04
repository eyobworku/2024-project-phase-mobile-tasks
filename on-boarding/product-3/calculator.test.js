const { add } = require("./calculator");

describe("add", () => {
  test("should add two positive numbers correctly", () => {
    expect(add(2, 3)).toBe(5);
  });
});
