% Create a biograph object.
function createBiograph(AdjacencyMatrix,n,nf)
% AdjacencyMatrix = ...
%   [1 1 1 1 0 0 1 0 0;
%    1 1 1 0 1 0 0 1 0;
%    1 1 1 0 0 1 0 0 1;
%    1 0 0 1 1 1 1 0 0;
%    0 1 0 1 1 1 0 1 0;
%    0 0 1 1 1 1 0 0 1;
%    1 0 0 1 0 0 1 1 1;
%    0 1 0 0 1 0 1 1 1;
%    0 0 1 0 0 1 1 1 1;];
AdjacencyMatrix = AdjacencyMatrix - eye(9);
B = tril(AdjacencyMatrix');    
    
IDS={'1','2','3','4','5','6','7','8','9'};
graph = biograph(B,IDS,'ShowArrows','off');
x1 = [];
x2 = [];
for i = 1:n
    x1 = [x1 i];
end
for i = n+1:n+nf
    x2 = [x2 i];
end
set(graph.nodes(x2),'Color',[240 128 128]/255,'LineColor',[0 0 0]);
set(graph.nodes(x1),'Color',[1 1 1],'LineColor',[0 0 0]);
set(graph.nodes,'shape','circle');
set(graph.edges,'LineColor',[0 0 0]);
set(graph.edges,'LineWidth',1);


dolayout(graph);
graph.nodes(1).Position = [0 400]/5;
graph.nodes(2).Position = [200 400]/5;
graph.nodes(3).Position = [400 400]/5;
graph.nodes(4).Position = [0 200]/5;
graph.nodes(5).Position = [200 200]/5;
graph.nodes(6).Position = [400 200]/5;
graph.nodes(7).Position = [0 0]/5;
graph.nodes(8).Position = [200 0]/5;
graph.nodes(9).Position = [400 0]/5;
dolayout(graph, 'Pathsonly', true);

view(graph);
