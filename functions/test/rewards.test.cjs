const test = require('node:test');
const assert = require('node:assert/strict');
const { levelForXp, xpForDifficulty } = require('../lib/rewards.js');

test('awards configured XP by task difficulty', () => {
  assert.equal(xpForDifficulty('easy'), 10);
  assert.equal(xpForDifficulty('medium'), 20);
  assert.equal(xpForDifficulty('hard'), 30);
  assert.throws(() => xpForDifficulty('impossible'), RangeError);
});

test('calculates levels at the requested 100 XP thresholds', () => {
  assert.equal(levelForXp(0), 1);
  assert.equal(levelForXp(99), 1);
  assert.equal(levelForXp(100), 2);
  assert.equal(levelForXp(200), 3);
  assert.throws(() => levelForXp(-1), RangeError);
});