function visualizeModalMass(M,K,fig)
figure(fig);
subplot(1,2,1)
bar3(M)
zlabel("質点質量[kg]")
xlabel("Node Index")
ylabel("Node Index")
subplot(1,2,2)
bar3(K)
xlabel("Node Index")
ylabel("Node Index")
zlabel("剛性[N/m]")

end