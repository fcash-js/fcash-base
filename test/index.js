'use strict';

var should = require('chai').should();
var fcash_base = require('../');

describe('Library', function() {
  it('should export primatives', function() {
    should.exist(fcash_base.crypto);
    should.exist(fcash_base.encoding);
    should.exist(fcash_base.util);
    should.exist(fcash_base.errors);
    should.exist(fcash_base.Address);
    should.exist(fcash_base.Block);
    should.exist(fcash_base.MerkleBlock);
    should.exist(fcash_base.BlockHeader);
    should.exist(fcash_base.HDPrivateKey);
    should.exist(fcash_base.HDPublicKey);
    should.exist(fcash_base.Networks);
    should.exist(fcash_base.Opcode);
    should.exist(fcash_base.PrivateKey);
    should.exist(fcash_base.PublicKey);
    should.exist(fcash_base.Script);
    should.exist(fcash_base.Transaction);
    should.exist(fcash_base.URI);
    should.exist(fcash_base.Unit);
  });
});
