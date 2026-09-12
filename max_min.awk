#https://unix.stackexchange.com/questions/580175/how-to-extract-maximum-and-minimum-value-from-column-1-and-column-2
### awk -f script.awk file
## Column 1: min=0.0000, max=0.4916
## Column 2: min=-24.1254, max=-23.4334
##


NF == 0 {
        # Skip any line that does not have data
        next
}

!initialized {
        # Initialize the max and min for each column from the
        # data on the first line of input that has data.
        # Then immediately skip to next line.

        nf = NF

        for (i = 1; i <= nf; ++i)
                max[i] = min[i] = $i

        initialized = 1
        next
}

{
        # Loop over the columns to see if the max and/or min
        # values need updating.

        for (i = 1; i <= nf; ++i) {
                if (max[i] < $i) max[i] = $i
                if (min[i] > $i) min[i] = $i
        }
}

END {
        # Output max and min values for each column.

        for (i = 1; i <= nf; ++i)
                printf("Column %d: min=%s, max=%s\n", i, min[i], max[i])
}


