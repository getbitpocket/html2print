var parser = require('../index');

describe("html2print tests", function() {

    it("h1 translation", function() {
        var output = parser.parse('<h1 class="align-center bold">hello</h1>');
        expect(output[0]).toEqual('\x1b\x21\x10\x1b\x21\x20\x1b\x61\x01\x1b\x45\x01hello\x0a\x1b\x40');
    });

});