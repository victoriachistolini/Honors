num_obs = [3
4
6
11
15
32
65
0
2
4
4
6
32
139
17
23
81
147
210
439
722
128
175
366
763
991
1510
1857
206
259
576
1127
1433
1942
2298
127
199
464
952
1286
1777
2135
85
124
258
576
746
1114
1561
20
23
49
113
173
310
542
2
2
7
18
33
66
125
4
7
17
97
204
673
1482
350
475
943
1735
2092
2613
2953
252
331
636
1244
1623
2464
2943
11
17
37
119
198
533
1035];

scores = [0.9074
0.9402
0.945
0.9569
0.9714
0.9442
0.9317
nan
0.9915
0.9935
0.9905
0.9237
0.9275
0.9164
0.9469
0.9524
0.9412
0.9176
0.8873
0.827
0.7733
0.9231
0.9103
0.8483
0.755
0.7293
0.676
0.6501
0.887
0.8737
0.7853
0.7073
0.6752
0.6419
0.6223
0.9049
0.8796
0.7985
0.7197
0.6776
0.6457
0.6254
0.9126
0.9104
0.844
0.7746
0.7434
0.6942
0.6605
0.9407
0.9372
0.9072
0.8859
0.8664
0.833
0.7776
0.9875
0.9875
0.8659
0.9315
0.9134
0.877
0.8696
0.8914
0.9233
0.9268
0.9148
0.8654
0.7595
0.6701
0.8444
0.8076
0.7317
0.6571
0.6393
0.6179
0.603
0.8777
0.8442
0.7796
0.7002
0.6692
0.6283
0.6131
0.9417
0.9571
0.9567
0.9089
0.8832
0.7954
0.731];



figure;
scatter(num_obs,scores);
xlabel('Number of Observations');
ylabel('AUC');