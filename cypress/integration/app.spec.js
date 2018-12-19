context("JSON Pretty Printing App", () => {
  beforeEach(() => {
    cy.visit("http://localhost:8080/")
  })

  it("does not format JSON automatically", () => {
    cy.get("textarea")
      .clear()
      .type("[1, 2,3,\n   4]")
    // makes sure nothing happens
    cy.wait(100)
    cy.get("textarea")
      .invoke("val")
      .should("eq", "[1, 2,3,\n   4]")
  })

  it("formats JSON when you press the button", () => {
    cy.get("textarea")
      .clear()
      .type("[1, 2,3,\n   4]")
    cy.get("button").click()
    cy.get("textarea")
      .invoke("val")
      .should("eq", "[1, 2, 3, 4]")
  })
})
