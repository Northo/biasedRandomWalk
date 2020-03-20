import numpy as np
import matplotlib.pyplot as plt
import matplotlib.animation as animation
import sys

try:
    datafile = sys.argv[1]
except IndexError:
    datafile = "end_time_40_dt_1E-3_D=2E-4_num_iterations_100_Ts_0.1_1_3_5_alpha0.2.txt"

colors = plt.rcParams["axes.prop_cycle"]
colors = list(colors)
series_to_use = [0]
sample = 200
print("Reading file...")
data = np.loadtxt(datafile, unpack=True, ndmin=2)
print("Done.")

xs = data[series_to_use]

ims = []

for i in range(len(xs[0][::sample])):
    artists = []
    for j, x in enumerate(xs):
        artists.append(plt.scatter(x[i*sample], j, **colors[j%len(colors)]))
    ims.append(artists)

fig, ax = plt.subplots()
anim = animation.ArtistAnimation(fig, ims, interval=30, blit=True, repeat_delay=1000)
#plt.close(anim._fig)
with open("myvid.html", "w") as io:
    print(anim.to_html5_video(), file=io)
plt.show()
