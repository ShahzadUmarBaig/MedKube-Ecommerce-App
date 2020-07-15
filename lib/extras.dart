/*

SliverList(
delegate: SliverChildListDelegate([
SectionHeading(
heading: "Popular Items",
),
]),
),
SliverToBoxAdapter(
child: Container(
height: 120,
child: ListView.builder(
scrollDirection: Axis.horizontal,
itemCount: 18,
itemBuilder: (context, index) {
return GestureDetector(
onTap: () {},
child: Card(
elevation: kElevationConstant,
margin: EdgeInsets.all(10),
child: Container(
decoration: BoxDecoration(
image: DecorationImage(
scale: 10,
image: NetworkImage(
"https://products.dawaai.pk/2014/04/345/zoom/rocacc345_101529997052.jpg"),
),
borderRadius: BorderRadius.all(
Radius.circular(15),
),
),
width: 100,
),
),
);
}),
),
),
 */
