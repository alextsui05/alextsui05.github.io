+++
date = '2025-02-05T02:01:32Z'
draft = false
title = 'Bitwise XOR of All Pairings'
description = 'Why'
tags = ['bit manipulation']
+++

# Problem

You have two arrays of non-negative integers `nums1` and `nums2`. Let `nums3` be the array of the XOR of all pairings between `nums1` and `nums2`. Return the XOR of all integers in `nums3`.

# Approach

The description is essentially one big XOR sum of XOR'd pairs, which makes me think this is an exercise in the properties of XOR. Since XOR is commutative, we can just ignore the fact that the numbers are paired and tally the overall frequency of each number. If the frequency is even, that number goes to 0, otherwise the number stays.

So consider Example 1:

**Input:** nums1 = [2,1,3], nums2 = [10,2,5,0]
**Output:** 13
**Explanation:**
A possible nums3 array is [8,0,7,2,11,3,4,1,9,1,6,3].
The bitwise XOR of all these numbers is 13, so we return 13.

Let's examine the appearances of each value.

```
{
  1: 4,
  2: 7,
  3: 4,
  10: 3,
  5: 3,
  0: 3
}
```

The only numbers that contribute to the end sum are 2, 5, and 10. Their XOR is 13.

## Code

```javascript
/**
 * @param {number[]} nums1
 * @param {number[]} nums2
 * @return {number}
 */
var xorAllNums = function(nums1, nums2) {
    const tally = {};
    const n1 = nums1.length;
    const n2 = nums2.length;
    nums1.forEach(value => {
        tally[value] ||= 0;
        tally[value] += n2;
    });
    nums2.forEach(value => {
        tally[value] ||= 0;
        tally[value] += n1;
    });
    let result = 0;
    for (const [val, count] of Object.entries(tally)) {
        if (count % 2 == 1) {
            result ^= val;
        }
    }
    return result;
};
```
