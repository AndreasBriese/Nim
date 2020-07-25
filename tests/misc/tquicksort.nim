proc QuickSort(list: seq[int]): seq[int] =
    if len(list) == 0:
        return @[]
    var pivot = list[0]
    var pivots: seq[int] = @[]
    var left: seq[int] = @[]
    var right: seq[int] = @[]
    for i in low(list)..high(list):
        if list[i] < pivot:
            left.add(list[i])
        elif list[i] > pivot:
            right.add(list[i])
        else:
            pivots.add(pivot)
    result = QuickSort(left) &
      pivots &
      QuickSort(right)

let list = QuickSort(@[89,23,15,23,56,123,356,12,7,1,6,2,9,4,3])
let expected = @[1, 2, 3, 4, 6, 7, 9, 12, 15, 23, 23, 56, 89, 123, 356]

doAssert list == expected

# faster
proc QuickSortInplace[t](a: var openarray[t], firstidx = 0, lastidx = -1) =
    var last = lastidx
    if last <= 0:
        last = a.high
    var first = firstidx
    let n = last - first + 1

    if n < 2:
        return
    elif n < 21: # insertsort
        for i in first..last:
            var j = i
            while (j > 0) and (a[j-1] > a[j]):
                swap(a[j], a[j-1])
                j -= 1
        return

    let p = a[first + 3 * n shr 2]
    while first <= last:
        if a[first] < p:
            first += 1
            # continue
        elif a[last] > p:
            last -= 1
            # continue
        else:
            swap(a[last], a[first])
            first += 1
            last -= 1

    QuickSortInplace(a, firstidx, last)
    QuickSortInplace(a, first, lastidx)

var qslist = @[89,23,15,23,56,123,356,12,7,1,6,2,9,4,3]
QuickSortInplace(qslist)
doAssert qslist == expected
