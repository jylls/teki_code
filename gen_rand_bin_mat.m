function rnd_bin_mat=gen_rand_bin_mat(s1,s2,c_sum)
rnd_bin_mat=zeros(s1,s2);
rnd_bin_mat(1:c_sum,:)=1;
for i=1:s2
    temp_ind=randperm(s1);
    rnd_bin_mat(:,i)=rnd_bin_mat(temp_ind,i);
end