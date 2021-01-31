const router = [
  {
    path: '/blocks-plugin-system-tools',
    name: 'Home',
    component: () => import(/* webpackChunkName: "home" */ '../views/Home.vue'),
    children: [
      {
        path: 'code-generator',
        name: 'CodeGenerator',
        component: () => import(/* webpackChunkName: "codeGenerator" */ '../views/CodeGenerator.vue')
      }
    ]
  }
]

export default router
