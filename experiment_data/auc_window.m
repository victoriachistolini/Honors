
% 15,46,74,105,135,146,166,196,227, 258, 288, 319, 349 
windows = [2,3,7,15,20,30,40];
% Day 15

num_obs15 = [3
4
6
11
15
32
65]/65;

scores15 = [0.9074
0.9402
0.945
0.9569
0.9714
0.9442
0.9317];

figure;
scatter(windows,scores15);
hold on;
scatter(windows,num_obs15);
xlabel('Window Size');
ylabel('Percent');
legend('AUC','Observations');

% Day 46

num_obs46 = [0
2
4
4
6
32
139]/139;

scores46 = [nan
0.9915
0.9935
0.9905
0.9237
0.9275
0.9164];

figure;
scatter(windows,scores46);
hold on;
scatter(windows,num_obs46);
xlabel('Window Size');
ylabel('Percent');
legend('AUC','Observations');

% Day 74

num_obs74 = [17
23
81
147
210
439
722]/722;

scores74 = [0.9469
0.9524
0.9412
0.9176
0.8873
0.827
0.7733];

figure;
scatter(windows,scores74);
hold on;
scatter(windows,num_obs74);
xlabel('Window Size');
ylabel('Percent');
legend('AUC','Observations');

% day 105

num_obs105 =[128
175
366
763
991
1510
1857]/1857;

scores105 = [0.9231
0.9103
0.8483
0.755
0.7293
0.676
0.6501];

figure;
scatter(windows,scores105);
hold on;
scatter(windows,num_obs105);
xlabel('Window Size');
ylabel('Percent');
legend('AUC','Observations');

% day 135

num_obs135 = [206
259
576
1127
1433
1942
2298]/2298;

scores135 = [0.887
0.8737
0.7853
0.7073
0.6752
0.6419
0.6223];

figure;
scatter(windows,scores135);
hold on;
scatter(windows,num_obs135);
xlabel('Window Size');
ylabel('Percent');
legend('AUC','Observations');

% day 146
num_obs146 = [127
199
464
952
1286
1777
2135]/2135;

scores146 = [0.9049
0.8796
0.7985
0.7197
0.6776
0.6457
0.6254];

figure;
scatter(windows,scores146);
hold on;
scatter(windows,num_obs146);
xlabel('Window Size');
ylabel('Percent');
legend('AUC','Observations');

% Day 166

num_obs166 = [85
124
258
576
746
1114
1561]/1561;

scores166 = [0.9126
0.9104
0.844
0.7746
0.7434
0.6942
0.6605];

figure;
scatter(windows,scores166);
hold on;
scatter(windows,num_obs166);
xlabel('Window Size');
ylabel('Percent');
legend('AUC','Observations');


% Day 196

num_obs196 = [20
23
49
113
173
310
542]/542;

scores196 = [0.9407
0.9372
0.9072
0.8859
0.8664
0.833
0.7776];

figure;
scatter(windows,scores196);
hold on;
scatter(windows,num_obs196);
xlabel('Window Size');
ylabel('Percent');
legend('AUC','Observations');

% Day 227 
num_obs227 = [2
2
7
18
33
66
125]/125;

scores227 = [0.9875
0.9875
0.8659
0.9315
0.9134
0.877
0.8696];

figure;
scatter(windows,scores227);
hold on;
scatter(windows,num_obs227);
xlabel('Window Size');
ylabel('Percent');
legend('AUC','Observations');

% Day 258
num_obs258 = [4
7
17
97
204
673
1482]/1482;


scores258 = [0.8914
0.9233
0.9268
0.9148
0.8654
0.7595
0.6701];

figure;
scatter(windows,scores258);
hold on;
scatter(windows,num_obs258);
xlabel('Window Size');
ylabel('Percent');
legend('AUC','Observations');

% Day 288
num_obs288 = [350
475
943
1735
2092
2613
2953]/2953;

scores288 = [0.8444
0.8076
0.7317
0.6571
0.6393
0.6179
0.603];


figure;
scatter(windows,scores288);
hold on;
scatter(windows,num_obs288);
xlabel('Window Size');
ylabel('Percent');
legend('AUC','Observations');

% Day 319
num_obs319 = [252
331
636
1244
1623
2464
2943]/2943;

scores319 = [0.8777
0.8442
0.7796
0.7002
0.6692
0.6283
0.6131];

figure;
scatter(windows,scores319);
hold on;
scatter(windows,num_obs319);
xlabel('Window Size');
ylabel('Percent');
legend('AUC','Observations');

% Day 349
num_obs349 = [11
17
37
119
198
533
1035]/1035;

scores349 = [0.9417
0.9571
0.9567
0.9089
0.8832
0.7954
0.731];

figure;
scatter(windows,scores349);
hold on;
scatter(windows,num_obs349);
xlabel('Window Size');
ylabel('Percent');
legend('AUC','Observations');
