<https://ithelp.ithome.com.tw/articles/10305904>

#### window = hamming(256); (1)
#### noverlap = 128; (2)
nfft = 512; (3)
fz = 250;


(1)：每個窗戶包含256點data
(2)：每個window包含128重疊點
(3)：頻率分辨率=250/512~=0.488Hz =>頻譜圖中每個頻率點間隔=0.4888Hz
