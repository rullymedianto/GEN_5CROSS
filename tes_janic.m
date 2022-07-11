tic

numb=500;

parfor i=1:numb 

[outArray1(i),outArray2(i),outArray3(i),outArray4(i),outArray5(i),outArray6(i)] = Gabungan();

end

hasil = [outArray1',outArray2',outArray3',outArray4',outArray5',outArray6'];

writematrix(hasil,'Hasil_Janic_2.csv')

toc