const xpByDifficulty: Record<string, number> = {
  easy: 10,
  medium: 20,
  hard: 30,
};

export function xpForDifficulty(difficulty: unknown): number {
  if (typeof difficulty !== 'string' || !(difficulty in xpByDifficulty)) {
    throw new RangeError('Unsupported task difficulty.');
  }
  return xpByDifficulty[difficulty];
}

export function levelForXp(totalXp: number): number {
  if (!Number.isSafeInteger(totalXp) || totalXp < 0) {
    throw new RangeError('Total XP must be a non-negative safe integer.');
  }
  return Math.floor(totalXp / 100) + 1;
}