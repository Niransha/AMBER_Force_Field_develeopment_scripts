import re

input_file = "rmsd_all.dat"
output_file = "output.dat"
cutoff = 2.5

with open(input_file) as f:
    lines = [line.strip() for line in f if line.strip() and not line.startswith("#")]

results = []

    #go over rows 
for line in lines:
    cols = line.split()

        #extract frame numbers fisrt columns 
    frame = int(cols[0])
         # Extract ToFirstAll value (second column)
    to_first_all = float(cols[1])
    
         # Extract rest of columns (first vs cluster_X)
    cluster_data = cols[2:]

    #initiate varibles     
    min_rmsd = float("inf")
    min_cluster = None
                        #loop over column by 2 , as i 0 2 4 6 
    for i in range(0, len(cluster_data), 2):
        cluster_frame = int(cluster_data[i])  # same as frame, ignored
        cluster_value = float(cluster_data[i + 1]) # cluster_X 
        cluster_id = i // 2 + 1  # intiger divisioon of flot when i=0 id=1 , i=2 id=1

        if cluster_value < min_rmsd:
            min_rmsd = cluster_value
            min_cluster = f"cluster_{cluster_id}"

    # Apply cutoff 2.5
    if min_rmsd > cutoff:
        min_cluster = "cluster_null"

    results.append((frame, to_first_all, min_cluster, min_rmsd))

with open(output_file, "w") as out:
    out.write("#Frame\tToFirstAll\tCluster\tMin_RMSD\n")
    for r in results:
        out.write(f"{r[0]}\t{r[1]:.4f}\t{r[2]}\t{r[3]:.4f}\n")

print(f"Output written to {output_file}")



