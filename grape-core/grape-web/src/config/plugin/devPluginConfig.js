// 开发环境下配置插件菜单和app信息

const pluginWebAppInfos = [
  {
    appName: 'blocks-plugin-system-tools',
    appPath: 'http://127.0.0.1:8082/plugin-web/blocks-plugin-system-tools/',
    rootRouting: '/blocks-plugin-system-tools'
  }
]

const navigationInfos = [
  {
    id: '1000',
    parentId: '0',
    key: 'plugin-dev-menus',
    path: '',
    redirect: '/blocks-plugin-system-tools/code-generator',
    component: 'RouteView',
    meta: {
      title: '插件菜单(dev)',
      show: true,
      icon: 'hdd'
    }
  },
  {
    id: '1001',
    parentId: '1000',
    key: 'code-generator',
    path: '/blocks-plugin-system-tools/code-generator',
    redirect: null,
    component: 'PluginExtensionWeb',
    meta: {
      title: '生成代码',
      show: true,
      icon: 'code'
    }
  }
]

export const getDevApp = () => {
  return pluginWebAppInfos
}

export const getDevMenu = () => {
  return navigationInfos
}
