'use strict';

var should = require('chai').should();
var fcore = require('../');

describe('Library', function() {
  it('should export primatives', function() {
    should.exist(fcore.crypto);
    should.exist(fcore.encoding);
    should.exist(fcore.util);
    should.exist(fcore.errors);
    should.exist(fcore.Address);
    should.exist(fcore.Block);
    should.exist(fcore.MerkleBlock);
    should.exist(fcore.BlockHeader);
    should.exist(fcore.HDPrivateKey);
    should.exist(fcore.HDPublicKey);
    should.exist(fcore.Networks);
    should.exist(fcore.Opcode);
    should.exist(fcore.PrivateKey);
    should.exist(fcore.PublicKey);
    should.exist(fcore.Script);
    should.exist(fcore.Transaction);
    should.exist(fcore.URI);
    should.exist(fcore.Unit);
  });
});
