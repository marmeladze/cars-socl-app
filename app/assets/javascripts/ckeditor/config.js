CKEDITOR.editorConfig = function( config ) {
  config.toolbar = 'MyToolbar';
  config.toolbar_MyToolbar = [
    { name: 'document', items : [ 'NewPage','Preview' ] },
    { name: 'clipboard' },
    { name: 'editing' },
    { name: 'insert' },
    { name: 'styles', items : [ 'Font', 'Format' ] },
    { name: 'basicstyles', items : [ 'Bold','Italic' ] },
    { name: 'paragraph', items : [ 'NumberedList','BulletedList' ] },
    { name: 'links', items : [ 'Link','Unlink' ] },
    { name: 'tools', items : [ 'Maximize','-','About' ] }
  ];
  config.removePlugins = 'elementspath';
};
