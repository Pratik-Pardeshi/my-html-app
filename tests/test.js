// A simple test script (you may want to use a real testing framework)
const assert = require('assert');

function testTitle() {
    const title = "My HTML Application";
    assert.strictEqual(title, "My HTML Application");
    console.log("Test passed!");
}

testTitle();
